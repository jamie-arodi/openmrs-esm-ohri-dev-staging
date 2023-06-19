#!/usr/bin/env sh

# Rename the directory with suffix _backup_current_timestamp

if [ -d "ohri-docs" ]; then
    mv frontend_modules frontend_modules_backup_$(date +%Y%m%d_%H%M%S)
    echo "--- OHRI Namibia Backup successful ---"
else
    echo "--- frontend_modules folder not found, backup not performed ---"
fi

# Clone the repository with the reference branch named dev
git clone --branch dev https://github.com/UCSF-IGHS/openmrs-esm-ohri.git

# Navigate into the cloned directory
echo "--- Navigate into the cloned directory ---"
cd openmrs-esm-ohri
ls -la -t

# Install dependencies and build the code
echo "--- Installing dependencies and building the code ---"
npx yarn install
npx yarn build

ls -la -t

# Copy the built code to the specified path on the server using scp
# scp -r ./build user@server:/usr/share/tomcat/microfrontends/ohri-docs
sh update_microfrontends.sh
cp -r ./frontend_namibia.zip ../tomcat/.OpenMRS