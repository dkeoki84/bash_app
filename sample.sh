#! /bin/bash
# bash environments sample
# export ENV_1="Environment 1"

# print format
printf "\n=== BASH SAMPLE APP ===\n"

# ==============
# CONSTANTS
# ==============
CONST_NUM=1234
CONST_STR="HELLO WORLD"

# ENUMS
CONST_FLAG_1=1
CONST_FLAG_2=2
CONST_FLAG_3=4
CONST_FLAG_4=8
CONST_FLAG_5=16
CONST_FLAG_6=32
CONST_FLAG_7=64
CONST_FLAG_8=128

DEFAULT_MODE=$((\
    CONST_FLAG_1 |\
    CONST_FLAG_2 |\
    CONST_FLAG_3 |\
    CONST_FLAG_4 \
    ))

# INITIAL
ENV_1_WITH_DEFAULT="DEFAULT_1"
ENV_2=""
ENV_3=""
DIRECT_CMDLINE_ARG=false

# switch
while getopts "i:j:k:" opt; do
case ${opt} in
    i)
        # arg1 - optional
        ENV_1_WITH_DEFAULT="${OPTARG}"
        DIRECT_CMDLINE_ARG=true
        ;;

    j)
        # arg2 - needed
        ENV_2="${OPTARG}"
        ;;

    k)
        # arg3 - needed
        ENV_3="${OPTARG}"
        ;;

    *)
        # unknown
        echo "Unknown arg - ${OPTARG}"
        ;;
esac
done

# =======================
# FUNCTION
# =======================
# check if variable is empty
validate_empty() {

if [ -z "$1" ]; then
    echo "$2 not exported."
    echo "Exiting process..."
    exit 1
fi

}

# validate needed variable
check_required() {
    validate_empty "$ENV_2" "ENV_2"
    validate_empty "$ENV_3" "ENV_3"
}

COUNTER=0

# step 1
step_1() {
    printf "\n--- step 1 ---\n"

    echo ${ENV_1_WITH_DEFAULT}
    echo ${ENV_2}
    echo ${ENV_3}

    ((COUNTER++))
}

# step 1
step_2() {
    printf "\n--- step 2 ---\n"

    echo "ENUM SAMPLE"
    if [ $((DEFAULT_MODE & CONST_FLAG_1)) -gt 0 ]; then
        echo "CONST_FLAG_1..."
    fi
    if [ $((DEFAULT_MODE & CONST_FLAG_2)) -gt 0 ]; then
        echo "CONST_FLAG_2..."
    fi
    if [ $((DEFAULT_MODE & CONST_FLAG_3)) -gt 0 ]; then
        echo "CONST_FLAG_3..."
    fi
    if [ $((DEFAULT_MODE & CONST_FLAG_4)) -gt 0 ]; then
        echo "CONST_FLAG_4..."
    fi

    if [ $((DEFAULT_MODE & CONST_FLAG_5)) -gt 0 ]; then
        echo "CONST_FLAG_5..."
    else
        echo "not CONST_FLAG_5"
    fi
    if [ $((DEFAULT_MODE & CONST_FLAG_6)) -gt 0 ]; then
        echo "CONST_FLAG_6..."
    else
        echo "not CONST_FLAG_6"
    fi
    if [ $((DEFAULT_MODE & CONST_FLAG_7)) -gt 0 ]; then
        echo "CONST_FLAG_7..."
    else
        echo "not CONST_FLAG_7"
    fi
    if [ $((DEFAULT_MODE & CONST_FLAG_8)) -gt 0 ]; then
        echo "CONST_FLAG_8..."
    else
        echo "not CONST_FLAG_8"
    fi

    ((COUNTER++))
}

# step 1
step_3() {
    printf "\n--- step 3 ---\n"

    RET=`ls`
    echo ${RET}
    printf "\n--------------\n"

    ((COUNTER++))
}

# ====================
# MAIN
# ====================
check_required

if $DIRECT_CMDLINE_ARG; then
    printf "\n@@@ DIRECT_CMDLINE_ARG=true @@@@\n"
    while true
    do
        step_1

        if [ $COUNTER -ge 3 ]; then
            echo "quiting!"
            break
        else
            echo "sleeping..."
            sleep 1
        fi
    done
else
    printf "\n@@@ DIRECT_CMDLINE_ARG=false @@@@\n"
    step_1
    step_2
    step_3
fi


# EC2_INSTANCE_ID=$(ec2metadata --instance-id)
# aws autoscaling terminate-instance-in-auto-scaling-group --instance-id $EC2_INSTANCE_ID --should-decrement-desired-capacity --endpoint-url $AWS_SCALE_GROUP_ENDPOINT_URL

# SQS_MESSAGE="`aws sqs receive-message --query-url $SQS_URL --endpoint-url $SQS_ENDPOINT_URL --attribute-names All --message-attribute-names All --max-number-of-message 1`"
# PARSE_MESSAGE="`echo $SQS_MESSAGE | jq -r '.Message[0] | .ReceiptHandle'`"
# aws sqs delete-message --query-url $SQS_URL --endpoint-url $SQS_ENDPOINT_URL --receipt-handle $PARSE_MESSAGE