# helper functions
# assume-role
                                                                                                                                                                                  
function assume-role () {                                                                                                                                                         
      PROFILE="${1:-flowstaging}"                                                                                                                                                     
      ASSUME_ROLE_PATH="/Users/balmanrawat/dotfiles/scripts/assume-role.py"                                                                                                                        
      eval $(python $ASSUME_ROLE_PATH $PROFILE)                                                                                                                                   
}                                                                                                                                                                                 
 
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

function 2fa-keys(){
    keyname=${1:-sputnik-aws}
    2fa | awk /$keyname/'{print $1}' | clipcopy
}

