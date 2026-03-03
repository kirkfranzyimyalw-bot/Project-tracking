# Oracle Instant Client Installation Guide

## Step 1: Download Oracle Instant Client

### Option A: Browser Download (Recommended)

1. Go to: https://www.oracle.com/database/technologies/instant-client/winx64-64-downloads.html

2. Download these files:
   - **instantclient-basic-windows.x64-19.8.0.0.0dbru.zip** (~50MB)
   - **instantclient-sqlplus-windows.x64-19.8.0.0.0dbru.zip** (~3MB)

3. Extract both files to: `/opt/oracle/instantclient_19_8/`

### Option B: Command Line (Requires curl)

If you have curl and Oracle account credentials, you can download directly:

```bash
# Create installation directory
sudo mkdir -p /opt/oracle/instantclient_19_8

# Download (requires Oracle account)
curl -O -L "https://download.oracle.com/otn_software/linux/instantclient/instantclient-basic-linux.x64-19.8.0.0.0dbru.zip"
curl -O -L "https://download.oracle.com/otn_software/linux/instantclient/instantclient-sqlplus-linux.x64-19.8.0.0.0dbru.zip"

# Extract
unzip instantclient-basic-linux.x64-19.8.0.0.0dbru.zip -d /opt/oracle/instantclient_19_8/
unzip instantclient-sqlplus-linux.x64-19.8.0.0.0dbru.zip -d /opt/oracle/instantclient_19_8/

# Create symbolic link
cd /opt/oracle/instantclient_19_8
sudo ln -s libclntsh.dylib.19.8 libclntsh.dylib
```

## Step 2: Configure Environment Variables

Add to your `~/.zshrc`:

```bash
# Oracle Instant Client
export PATH=$PATH:/opt/oracle/instantclient_19_8
export LD_LIBRARY_PATH=/opt/oracle/instantclient_19_8
```

Then reload:
```bash
source ~/.zshrc
```

## Step 3: Verify Installation

```bash
# Check if sqlplus is available
which sqlplus

# Test connection
sqlplus -l
```

## Step 4: Connect to Database

```bash
sqlplus mestest/mestest@10.134.9.53:1521/ycmesdbtest
```

Expected output:
```
SQL*Plus: Release 19.8.0.0.0 - Production
Wed Mar  3 09:00:00 2026

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
```

## Step 5: Execute Schema Script

Once connected, execute:

```bash
@/Users/long/clawd/Project-tracking/docs/schema.sql
```

Or copy-paste the entire content of `schema.sql` into SQL*Plus.

## Troubleshooting

### sqlplus not found
- Ensure you added the path to ~/.zshrc
- Run `source ~/.zshrc` to reload
- Check if the directory exists: `/opt/oracle/instantclient_19_8`

### Connection refused
```bash
# Test network connectivity
nc -zv 10.134.9.53 1521

# If it fails, check:
# 1. Firewall settings
# 2. Database server is running
# 3. VPN is connected (if required)
```

### ORA-12154: TNS:could not resolve the connect identifier
- Check your connection string format
- Try: `mestest/mestest@10.134.9.53:1521/ycmesdbtest`
- Or: `mestest/mestest@ycmesdbtest` (with TNS alias)

### ORA-12541: TNS:no listener
- Database listener is not running
- Contact your DBA

## Alternative: Use SQL Developer

If you prefer a GUI, download [Oracle SQL Developer](https://www.oracle.com/tools/downloads/sqldev-downloads.html):

1. Download SQL Developer
2. Connect with:
   - **Username**: mestest
   - **Password**: mestest
   - **Connection Name**: ProjectTracking
   - **Connection Type**: Basic
   - **Host Name**: 10.134.9.53
   - **Port**: 1521
   - **SID**: ycmesdbtest

3. Execute `schema.sql` in the SQL Worksheet
