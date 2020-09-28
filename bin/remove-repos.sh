REPO_LIST=${1:- "~/.config/repo-list.txt"}
BASE_PATH=${2:- "~/projects"}
# Use jq to get repos from json config
repo_list=$(jq '.[] | .repo ' ${REPO_LIST}) 

# Strip remaining quotes
repo_list=$(echo $repo_list | xargs echo)  

IFS=" "
for repo in $(echo "${repo_list}");
do
    printf "\n----------------\n"
    printf "\nChecking for $repo\n"
    # Strip repo http
    repo_dir=$(echo $repo | cut -d/ -f5)
    repo_dir=$(echo $repo_dir | cut -d. -f1)

     [ -d "$repo_dir" ] && printf "\nDeleting$repo_dir \n" && rm -r $repo_dir || printf "\nWARNNG: Directory $repo_dir not found\n"  
    # Test for repo. If not there clone
 
done
unset IFS

