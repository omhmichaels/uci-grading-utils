# Title: Clone Repos

eval REPO_LIST=${1:- "~/.repos"}
eval BASE_PATH=${2:- "./"}
message=${3:- "Updated Grades"}



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


   # Move into Student Folder
    cd "${username}"

    # Test for repo. Pull if there
    [ -d "$repo_dir" ] && cd "$repo_dir";

    # Git IT
    git checkout -b "GRADING" || git checkout "GRADING"
    git add .;
    git commit -m "${message}";
    git push || git push -u origin "GRADING";

    
    # Return to projects root dir
    cd $BASE_PATH || cd ../../
    
done
unset IFS


printf "\nCloned Repos\n"

