# OP5 Monitor Administrator Manual

# Introduction

This guide will help make the most of an OP5 Monitor server configuration. This includes:

-    maximizing physical and virtual hardware resources
-    optimizing performance of the member applications (including the web server and API)
-    configuration agent and agentless target (host) setups
-    integrating with a variety of other tools

# What these pages offer you

You are busy. We get that. We are honored that you cracked open this page. The link you clicked wasn't purple until today.

You probably opened this page because you've been handed an OP5 Monitor environment as part of twenty-seven other services that you need to keep alive, make thrive, or evaluate for retirement. The previous admin is not around to help you.

You may instead be one of those rare people that can say, "I've been a Nagios admin since it was called Saint. You don't need to tell me anything." If you have the honor of being this expert, I still ask you to read the next section.

# If you remember nothing else on this opening page...

OP5 does not support editing configuration files directlly!

Editing OP5 configuration files directly (in other words: in '`/opt/monitor/etc`' on the OP5 server) ***is not supported!***

Later in this Guide we will present Livestatus, which parses the configuration files based on a temporary save file. Any manual edits could conflict with Livestatus data as well as anything passed to the API.

We need to make this as clear as possible. Many people reading this Guide may come from Nagios administration, where editing the configuration files and creating new files are commonplace. We beg of you to leave these files alone. Please let our complex of miniature databases serve your higher goals.

We will discuss the API and our Configure web page as our configuration tool in later chapters.

