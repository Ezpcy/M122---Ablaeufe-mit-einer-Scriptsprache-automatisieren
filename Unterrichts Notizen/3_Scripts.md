# Scripts

## Create a script file

To create a script file you can use the `nano` text editor. To create a new file called `script.sh` you can use the following command:

```bash
nano script.sh
```

This will open the `nano` text editor. You can now write your script. To save the file press `Ctrl` + `O` and to exit press `Ctrl` + `X`.

## Writing a Script

Inside the script file you can write your script. A script is a series of commands that are executed in order. You can use the same commands that you would use in the terminal. Here is an example script:

```bash
#!/bin/bash # This is the shebang. It tells the system that this is a bash script.

echo "Hello World!" # This will print "Hello World!" to the terminal window.
```

Save the file and exit the text editor. To make the script executable you can use the following command:

```bash
chmod +x script.sh
```

You can also use loops and conditions in your script. Here is an example script with a loop:

```bash
#!/bin/bash
for i in $(ls /var); do
    echo "im dir /var/ steht $i"
done

# with $() you can execute a command and use the output as a variable.
```

Change mode for multiple files using wildcards:

```bash
chmod +x *.sh
```

## Permissions

To show the permissions of a file you can use the `ls -l` command. This will show the permissions of the file. The permissions are displayed in the first column. The permissions are divided into three groups: user, group and others. The permissions are displayed as `r` for read, `w` for write and `x` for execute. If a permission is not granted it will be displayed as `-`.

To change the permissions of a file you can use the `chmod` command. The `chmod` command is followed by the permissions and the file name. The permissions are displayed as `u` for user, `g` for group and `o` for others. The permissions are displayed as `+` for add and `-` for remove. The permissions are displayed as `r` for read, `w` for write and `x` for execute. Here are some examples:

```bash
chmod u+x script.sh # This will add the execute permission for the user.
chmod g-w script.sh # This will remove the write permission for the group.
chmod o-r script.sh # This will remove the read permission for others.
chmod a+x script.sh # This will add the execute permission for all.
```

With the `chmod` command you can also use the numeric representation of the permissions. The permissions are displayed as `4` for read, `2` for write and `1` for execute. You can add the permissions together to get the desired permissions. Here are some examples:

```bash
chmod 755 script.sh # This will set the permissions to rwxr-xr-x.
chmod 644 script.sh # This will set the permissions to rw-r--r--.
```

7 is the sum of 4, 2 and 1. 6 is the sum of 4 and 2. 4 is the read permission. 2 is the write permission. 1 is the execute permission.
