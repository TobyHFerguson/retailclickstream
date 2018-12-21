# Submit a single hive job to the given altus cluster
# Arg1 - name of cluster
# Arg2 - path to file containing the hive sql
# [Arg3] - name of the job

usage() {
    echo Usage: submit-job.sh cluster-name path-to-hive-sql [job-name]
}

[ $# -eq 2 -o $# -eq 3 ] || {
    cat 1>&2 <<EOF
Insufficient arguments. Expected 2 or 3, got $#

$(usage)
EOF
    exit 1
}


cluster=$1
job_path=$2
name=${3:-$(basename ${job_path%.*})}

make_absolute() {
    (cd $(dirname $1); echo $(pwd)/$(basename $1))
}

job_file=$(make_absolute ${job_path:?})
[ -r ${job_file:?} ] || { echo ${job_path} is not readable - exiting; exit 2; }

altus dataeng submit-jobs \
      --cluster-name ${cluster:?} \
      --jobs "name=${name},hiveJob={script=file://${job_file:?}}"

