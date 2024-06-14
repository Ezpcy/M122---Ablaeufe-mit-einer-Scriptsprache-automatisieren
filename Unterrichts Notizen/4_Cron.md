# Cron/Crontab

The `cron` command-line utility is a job scheduler in Unix-like operating systems. Users can schedule jobs (commands or scripts) to run at specific times or intervals. The `cron` utility is driven by a configuration file called `crontab`.

## Overview

The actionss of cron are driven by **crontab** (cron table) files, which are configuration files that specify the scheduling of jobs. Each user can have their own crontab file, and the system can have a crontab file that applies to all users.

## How to Use

To edit the crontab file, use the following command:

```bash
crontab -e
```

This will open the crontab file in the default text editor (e.g., `vi` or `nano`). The crontab file consists of lines that specify the schedule and command to be executed.

The format of a crontab file is as follows:

```bash
# m h dom mon dow command
```

- `m`: Minute (0-59)
- `h`: Hour (0-23)
- `dom`: Day of the month (1-31)
- `mon`: Month (1-12)
- `dow`: Day of the week (0-7, where 0 and 7 are Sunday)

The `command` field specifies the command to be executed. For example, the following line will run the `backup.sh` script every day at 2:30 AM:

```bash
30 2 * * * /path/to/backup.sh
```

With `/` you can specify intervals. For example, `*/5` in the minute field means every 5 minutes:

```bash
*/5 * * * * /path/to/script.sh
```

- The above line will run the `script.sh` script every 5 minutes.

Run a script all 2 hours:

```bash
0 */2 * * * /path/to/script.sh
```

After editing the crontab file, the changes will take effect immediately.

To list the contents of the crontab file, use the following command:

```bash
crontab -l
```

To remove the crontab file, use the following command:

```bash
crontab -r
```

## Examples

### Example 1: Running a Script Every Hour

To run a script every hour, add the following line to the crontab file:

```bash
0 * * * * /path/to/script.sh
```

This will run the `script.sh` script at the beginning of every hour.

### Example 2: Running a Script Every Day at Midnight

To run a script every day at midnight, add the following line to the crontab file:

```bash
0 0 * * * /path/to/script.sh
```

This will run the `script.sh` script at midnight every day.

### Example 3: Running a Script Every Monday

To run a script every Monday, add the following line to the crontab file:

```bash
0 0 * * 1 /path/to/script.sh
```

- This will run the `script.sh` script at midnight every Monday.
