#!/bin/bash
# OpenOps Platform Configuration Script
# Instance: i-04216b668db9a2b73

set -e

echo "=== OpenOps Platform Configuration ==="
echo "Instance: i-04216b668db9a2b73"
echo "Region: us-east-1"
echo "IAM Role: openops-instance-role"

# Configuration tasks to run on the instance
cat << 'EOF' > /tmp/openops-setup.sh
#!/bin/bash

echo "1. Checking OpenOps service status..."
sudo systemctl status openops || echo "OpenOps service not found - will install"

echo "2. Installing OpenOps if needed..."
if ! command -v openops &> /dev/null; then
    echo "Installing OpenOps..."
    # Download and install OpenOps
    curl -L https://github.com/openops-cloud/openops/releases/latest/download/openops-linux-amd64 -o /tmp/openops
    sudo mv /tmp/openops /usr/local/bin/openops
    sudo chmod +x /usr/local/bin/openops
    
    # Create systemd service
    sudo tee /etc/systemd/system/openops.service > /dev/null << 'SERVICE'
[Unit]
Description=OpenOps Platform
After=network.target

[Service]
Type=simple
User=ec2-user
WorkingDirectory=/home/ec2-user
ExecStart=/usr/local/bin/openops server
Restart=always
RestartSec=5
Environment=AWS_REGION=us-east-1

[Install]
WantedBy=multi-user.target
SERVICE

    sudo systemctl daemon-reload
    sudo systemctl enable openops
fi

echo "3. Testing AWS connectivity..."
aws sts get-caller-identity || echo "AWS CLI not configured - needs setup"

echo "4. Starting OpenOps service..."
sudo systemctl start openops
sudo systemctl status openops

echo "5. Testing OpenOps API..."
sleep 5
curl -f http://localhost:8080/health || echo "OpenOps API not responding"

echo "6. Configuration complete!"
EOF

echo "Configuration script created. To run on instance:"
echo "1. SSH to instance: ssh -i ~/.ssh/openops.pem ec2-user@10.0.130.121"
echo "2. Copy and run the setup script"
echo "3. Or use Session Manager if available"

# Display next steps
echo ""
echo "=== Next Steps ==="
echo "1. Connect to instance and run setup script"
echo "2. Configure AWS credentials on instance"
echo "3. Set up Slack webhook integration"
echo "4. Test policy engine functionality"
echo "5. Validate AWS service integrations"