# How do i reset the root password

## Question 

* * * * *

How do i reset the root password?

## Answer

* * * * *

This is a short instruction on how to boot op5 Appliance System (or any other system..) into Single User mode for password recovery of the root account. Booting the system into single user mode is easy, all you need to do is interrupt the bootloader and change the arguments passed to the kernel during startup. To achieve this, follow these simple steps.

-   Make sure you have console access and reboot the server.
-   When the boot prompt show up, hit the keyboard a couple of time to stop grub from booting the kernel.
-   Push "a" button on your keyboard, this will give you a BASH look-a-like shell with a line similar to this:

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
grub append> ro root=LABEL=/ clocksource=pit nosmp noapic nolapic
```

-   Add the parameter "single" to this line and press enter to boot the system into single user mode.

``` {.bash data-syntaxhighlighter-params="brush: bash; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: bash; gutter: false; theme: Confluence"}
grub append> ro root=LABEL=/ clocksource=pit nosmp noapic nolapic single
```

-   When the server has booted up, you are in a root session and can change the password using "passwd" command.
-   Reboot the server without interrupting the boot loader.
-   Done!

