# Using templates

## About

Even though Configure makes it easy for you to add and change the configuration of OP5 Monitor it is still a lot of things to edit and tweak. To make the software even more easy to use templates have been built in.
There are three types of templates to use:

- host templates
  - service templates
  - contact templates

op5 Monitor comes with a couple of predefined templates for each object type described above. They are just there to be examples and you should really create your own.

## How they work

- Any directive set in a template will be used in the objects using the template. But if you set a directive explicit on an object that value will override the templates.
- Any directive not set in neither a template or directly on the object will have the OP5 Monitor default value.
- If you change any value on a directive in a template it will only be valid on the objects where the same directive is not set explicit.
