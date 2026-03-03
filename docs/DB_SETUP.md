# Database Setup Instructions

## Connection Information
- Host: 10.134.9.53
- Port: 1521
- SID: ycmesdbtest
- Username: mestest
- Password: mestest

## Step 1: Download Oracle Instant Client

### Option A: Manual Download
1. Go to: https://www.oracle.com/database/technologies/instant-client/winx64-64-downloads.html
2. Download:
   - **Basic Package** (instantclient-basic-windows.x64-19.8.0.0.0dbru.zip)
   - **SQL*Plus Package** (instantclient-sqlplus-windows.x64-19.8.0.0.0dbru.zip)

### Option B: Command Line (if available)
```bash
# This requires curl and wget
# Not all systems have these tools
```

## Step 2: Install Oracle Instant Client

1. Unzip both packages to a directory, e.g., `/opt/oracle/instantclient_19_8`

2. Create symbolic link:
```bash
sudo ln -s /opt/oracle/instantclient_19_8/libclntsh.dylib.19.8 /opt/oracle/instantclient_19_8/libclntsh.dylib
```

## Step 3: Configure Environment Variables

Add to `~/.zshrc`:
```bash
export PATH=$PATH:/opt/oracle/instantclient_19_8
export LD_LIBRARY_PATH=/opt/oracle/instantclient_19_8
```

Then reload:
```bash
source ~/.zshrc
```

## Step 4: Test Connection

```bash
sqlplus mestest/mestest@10.134.9.53:1521/ycmesdbtest
```

If successful, you should see:
```
Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
```

## Step 5: Execute Schema Script

Once connected, execute:
```bash
@/Users/long/clawd/Project-tracking/docs/schema.sql
```

Or copy-paste the contents of `schema.sql` into SQL*Plus.

## Step 6: Verify Tables

```sql
-- List all tables
SELECT table_name FROM user_tables;

-- Verify users table
SELECT * FROM users;

-- Should see 1 row (admin user)
```

## Troubleshooting

### If sqlplus not found:
- Ensure you added the path to ~/.zshrc and ran `source ~/.zshrc`
- Check if the directory exists

### If connection fails:
- Verify host and port: `nc -zv 10.134.9.53 1521`
- Check firewall settings
- Verify username/password

### If tables not created:
- Check for errors in SQL*Plus output
- Ensure you executed the script correctly
- Verify you're connected to the correct database
