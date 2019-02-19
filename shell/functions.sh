# helper functions

# ssh-config-gen helper
function hostgen(){

    # Host * !cloudfactory-devops-bastion1_vpc !github.com
    # ProxyCommand ssh -W %h:%p cloudfactory-devops-bastion1_vpc
    # User ubuntu
    # Port 2020
    # ForwardAgent yes
    PROFILE=${1:-staging}
    echo "Assuming: $PROFILE"
    echo "Generating.."
    assume-role $PROFILE && easyssh-go -port 2020 | tee ~/.ssh/config.d/$PROFILE
}
