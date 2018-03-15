#!/usr/bin/env python
__author__ = "Sam Sharpe, Misiu Pajor (op5 AB)"
__credits__ = ["Sam Sharpe", "Misiu Pajor (op5 AB)"]
__license__ = "MIT"
__version__ = '1.0.4'

import argparse
import json
import urllib
import sys

alert_colors = {'UNKNOWN': '#6600CC',
                'CRITICAL': '#FF0000',
		'DOWN':	'#FF0000',
                'WARNING': '#FF9900',
		'UP': '#36A64F',
                'OK': '#36A64F'}


class AttachmentField(dict):
    def __init__(self, title, value, short=False):
        self['title'] = title
        self['value'] = value
        self['short'] = short


class AttachmentFieldList(list):
    def __init__(self, *args):
        for count, field in enumerate(args):
            self.append(field)


class Attachment(dict):
    def __init__(self, fallback, fields, text=None, pretext=None, color=None):
        self['fallback'] = fallback
        self['fields'] = fields
        if text:
            self['text'] = text
        if pretext:
            self['pretext'] = pretext
        if color:
            self['color'] = color


class AttachmentList(list):
    def __init__(self, *args):
        for count, attachment in enumerate(args):
            self.append(attachment)


class Message(dict):
    def __init__(self, channel, text, username, mrkdwn_in=["fields"],
                 icon_emoji=":ghost:", attachments=None):
        self['channel'] = channel
        self['text'] = text
        if mrkdwn_in:
            self['mrkdwn_in'] = mrkdwn_in
        if username:
            self['username'] = username
        if icon_emoji:
            self['icon_emoji'] = icon_emoji
        self['attachments'] = AttachmentList()

    def attach(self, message, host, service, level, action_url=None, notes_url=None, status_url=''):
        fields = AttachmentFieldList()
        fields.append(AttachmentField("Message", message))
	fields.append(AttachmentField("Host", "<{1}/monitor/index.php/listview/?q=%5Bservices%5D%20host.name%20%3D%20\"{0}\"|{0}>".format(host, status_url), True))
	if service:
		fields.append(AttachmentField("Service", "<{2}/monitor/index.php/listview/?q=%5Bservices%5D%20host.name%20%3D%20\"{0}\"%20and%20description%20%3D%20\"{1}\"|{1}>".format(host, service, status_url), True))
        fields.append(AttachmentField("Level", level, True))
        if action_url:
            fields.append(AttachmentField("Actions URL", action_url, True))
        if notes_url:
            fields.append(AttachmentField("Notes URL", notes_url, True))
        if level in alert_colors.keys():
            color = alert_colors[level]
        else:
            color = alert_colors['UNKNOWN']
        alert_attachment = Attachment(fallback="    {0} on {1} is {2}".format(message, host, level), color=color, fields=fields)
        self['attachments'].append(alert_attachment)

    def send(self, token):
        data = urllib.urlencode({"payload": json.dumps(self)})
        response = urllib.urlopen('{0}'.format(token), data).read()
        if response == "ok":
            return True
        else:
            print "Error: %s" % response
            return False


def parse_options():
    parser = argparse.ArgumentParser(description="Send an OP5 Monitor Alert to Slack.com via a generic webhook integration")
    parser.add_argument('-c', metavar="CHANNEL", type=str, required=True, help="The channel to send the message to")
    parser.add_argument('-m', metavar="MESSAGE", type=str, required=True, help="The text of the message to send")
    parser.add_argument('-t', metavar="TOKEN", type=str, required=True, help="The access token for your integration")
    parser.add_argument('-A', metavar="SERVICEACTIONURL", type=str, default=None, help="An optional action_url for this alert {default: None}")
    parser.add_argument('-H', metavar="HOST", type=str, default="UNKNOWN", help="An optional host the message relates to {default: UNKNOWN}")
    parser.add_argument('-S', metavar="SERVICE", type=str, default=None, help="An optional service the message relates to {default: None}")
    parser.add_argument('-L', metavar="LEVEL", type=str, choices=["OK", "UP", "WARNING", "CRITICAL", "DOWN", "UNKNOWN"], default="UNKNOWN",
                        help="An optional alert level {default: UNKNOWN}")
    parser.add_argument('-M', metavar="HEADERMESSAGE", type=str, default="I have received the following alert:",
                        help="A header message sent before the formatted alert {default: I have received the following alert:}")
    parser.add_argument('-N', metavar="SERVICENOTESURL", type=str, default=None, help="An optional notes_url for this alert {default: None}")
    parser.add_argument('-X', metavar="STATUSURL", type=str, default='https://op5.company.com',
                        help="The URL to your OP5 Monitor instance {default: https://op5.company.com}")
    parser.add_argument('-U', metavar="USERNAME", type=str, default="OP5 Monitor", help="Username to send the message from {default: OP5 Monitor}")
    parser.add_argument('-V', action='version', help="Print version information", version="version: {0}".format(__version__))
    args = parser.parse_args()
    return args


def main():
    args = parse_options()
    message = Message(channel=args.c, text=args.M, username=args.U)
    message.attach(message=args.m, host=args.H, service=args.S, level=args.L, action_url=args.A, notes_url=args.N, status_url=args.X)
    if message.send(token=args.t):
        sys.exit(0)
    else:
        sys.exit(1)


if __name__ == "__main__":
    main()
