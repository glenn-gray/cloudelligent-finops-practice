#!/bin/bash
set -e
echo "🚀 Deploying Cloudelligent-Production infrastructure..."

for dir in */; do
    if [[ -d "$dir/iac-templates/terraform" ]]; then
        echo "📦 Deploying $dir"
        cd "$dir/iac-templates/terraform"
        terraform init
        terraform plan
        terraform apply -auto-approve
        cd - > /dev/null
    fi
done

echo "✅ Deployment complete!"
