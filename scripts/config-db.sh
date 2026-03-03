#!/bin/bash

# Database Configuration Script
# This script updates the .env file with your database connection

echo "======================================"
echo "Database Configuration"
echo "======================================"

# Database connection information
DB_HOST="10.134.9.53"
DB_PORT="1521"
DB_SID="ycmesdbtest"
DB_USERNAME="mestest"
DB_PASSWORD="mestest"

# .env file path
ENV_FILE="/Users/long/clawd/Project-tracking/.env"

# Create .env file if it doesn't exist
if [ ! -f "$ENV_FILE" ]; then
    echo "Creating .env file from .env.example..."
    cp /Users/long/clawd/Project-tracking/.env.example "$ENV_FILE"
fi

# Update .env file
echo "Updating database configuration..."
sed -i.bak "s|^DB_HOST=.*|DB_HOST=$DB_HOST|" "$ENV_FILE"
sed -i.bak "s|^DB_PORT=.*|DB_PORT=$DB_PORT|" "$ENV_FILE"
sed -i.bak "s|^DB_SID=.*|DB_SID=$DB_SID|" "$ENV_FILE"
sed -i.bak "s|^DB_USERNAME=.*|DB_USERNAME=$DB_USERNAME|" "$ENV_FILE"
sed -i.bak "s|^DB_PASSWORD=.*|DB_PASSWORD=$DB_PASSWORD|" "$ENV_FILE"

# Remove backup file
rm -f "$ENV_FILE.bak"

echo ""
echo "======================================"
echo "Configuration Complete!"
echo "======================================"
echo ""
echo "Database configuration:"
echo "  Host: $DB_HOST"
echo "  Port: $DB_PORT"
echo "  SID: $DB_SID"
echo "  Username: $DB_USERNAME"
echo ""
echo "Next steps:"
echo "1. Install Oracle Instant Client (see DB_SETUP.md)"
echo "2. Test database connection:"
echo "   sqlplus $DB_USERNAME/$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_SID"
echo "3. Execute schema.sql:"
echo "   @/Users/long/clawd/Project-tracking/docs/schema.sql"
echo ""
