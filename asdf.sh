#!/bin/zsh

# Function to install the latest patch versions for all latest minor versions of a given tool
asdf_install_latest_patch_versions() {
    tool_name=$1

    echo "Installing latest patch versions of all latest minor versions for $tool_name"

    # Initialize associative array for latest minor versions
    typeset -A latest_minor_versions

    if [[ "$tool_name" == "k9s" ]]; then
        # For k9s, only install the latest version
        latest_version=$(asdf list-all "$tool_name" | grep -vE 'alpha|beta|rc|\+' | tail -n1)
        latest_minor_versions["latest"]="$latest_version"
    else
        # Special handling for Java to include only OpenJDK versions
        if [[ "$tool_name" == "java" ]]; then
            available_versions=$(asdf list-all "$tool_name" | grep 'openjdk')
        else
            # List all available versions for the tool, excluding alpha, beta, rc, and special versions
            available_versions=$(asdf list-all "$tool_name" | grep -vE 'alpha|beta|rc|mini|pypy|conda|cinder|mambaforge|dev|micropython|stackless|jython|activepython|jython|pyston|nightly|graal|iron|nogil|adopt|\+')
        fi

        for version in ${(f)available_versions}; do
            # Extract major and minor version
            major_minor_version=$(echo "$version" | awk -F '.' '{print $1"."$2}')

            # Use sort to find the highest minor version for each major version
            higher_version=$(printf "%s\n%s" "${latest_minor_versions[$major_minor_version]}" "$version" | sort -V | tail -n1)

            if [[ "$higher_version" == "$version" ]]; then
                latest_minor_versions[$major_minor_version]="$version"
            fi
        done
    fi

    # Install and set the latest patch version for each latest minor version
    for version in "${latest_minor_versions[@]}"; do
        echo "Starting installation for $tool_name $version"
        asdf install "$tool_name" "$version" > "install_${tool_name}_${version}.log" 2>&1 &
    done

    # Wait for all background jobs to complete
    wait
    echo "All installations for $tool_name completed."
}

# Plugins to process
# plugins=("golang" "vault" "terraform" "kubectl" "k9s" "scala" "scala-cli" "python" "java" "nodejs" "ruby" "rust" "helm" "istioctl" "mysql" "cockroach" "redis" "mongodb")
plugins=("golang" "vault" "terraform" "kubectl" "k9s" "scala" "scala-cli" "python" "ruby" "rust" "helm" "istioctl" "mysql" "cockroach" "redis" "mongodb")

# Install latest versions for each tool
for plugin in $plugins; do
    asdf_install_latest_patch_versions "$plugin"
done

