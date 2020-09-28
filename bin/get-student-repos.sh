# Title: Clone Repos

REPO_LIST=${1:- "~/.repos"}
BASE_PATH=${2:- "./"}




### REPO DATA CLEANING ###
# Use jq to get repos from json config
repo_list=$(jq '.[] | .repo ' ${REPO_LIST}) 

# Strip remaining quotes
repo_list=$(echo $repo_list | xargs echo)  



### REPO CLONING ####
# Move to base dir 
cd $BASE_PATH
# Loop through and clone repos
IFS=" "
for repo in $(echo "${repo_list}");
do
    printf "\n----------------\n"
    printf "\nChecking for $repo\n"
    # Strip repo http
    username=$(echo $repo | cut -d/ -f4) 
    repo_dir=$(echo $repo | cut -d/ -f5)
    repo_dir=$(echo $repo_dir | cut -d. -f1)


    # Test for Student Folder. If not there create
    [ -d "$username" ] && printf "\nWARNNG: Directory $username exists.\nGracefully skipping....\n" || printf "\nCreating $username\n" &&mkdir ${username}
    # Move into Student Folder
    cd "${username}"

    # Test for repo. If not there clone
    [ -d "$repo_dir" ] && printf "\nWARNNG: Directory $repo exists.\nGracefully skipping....\n" || printf "\nCloning $repo\n" && git clone ${repo}
    
    # Return to projects root dir
    cd ../
    
done
unset IFS


printf "\nCloned Repos\n"

