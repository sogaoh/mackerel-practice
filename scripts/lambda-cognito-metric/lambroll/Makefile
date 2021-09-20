.PHONY:

help:
	cat Makefile

KEEP_NUM := 3

OPT_LOG      := --log-level=info
OPT_PROFILE  := --profile=${AWS_PROFILE}
OPT_REGION   := --region="ap-northeast-1"
OPT_FUNCTION := --function="function.json"
OPT_DEPLOY_FUNCTION := --function="function.json"
OPT_KEEP_VERSION := --keep-versions=$(KEEP_NUM)
OPT_TFSTATE := --tfstate="../create/terraform.tfstate"
OPT_SRC      := --src="../src"
OPT_EXCLUDE  := --exclude-file=".lambdaignore"


list:
	lambroll list $(OPT_PROFILE) $(OPT_REGION)

diff:
	lambroll diff $(OPT_LOG) $(OPT_PROFILE) $(OPT_REGION) $(OPT_FUNCTION) $(OPT_TFSTATE)


deploy:
	lambroll deploy $(OPT_LOG) $(OPT_PROFILE) $(OPT_REGION) $(OPT_DEPLOY_FUNCTION) $(OPT_TFSTATE) $(OPT_SRC) $(OPT_EXCLUDE) $(OPT_KEEP_VERSION)
dry-deploy:
	lambroll deploy $(OPT_LOG) $(OPT_PROFILE) $(OPT_REGION) $(OPT_DEPLOY_FUNCTION) $(OPT_TFSTATE) $(OPT_SRC) $(OPT_EXCLUDE) $(OPT_KEEP_VERSION) --dry-run

rollback:
	lambroll rollback $(OPT_LOG) $(OPT_PROFILE) $(OPT_REGION) $(OPT_FUNCTION) $(OPT_TFSTATE) --delete-version
soft-rollback:
	lambroll rollback $(OPT_LOG) $(OPT_PROFILE) $(OPT_REGION) $(OPT_FUNCTION) $(OPT_TFSTATE)
dry-rollback:
	lambroll rollback $(OPT_LOG) $(OPT_PROFILE) $(OPT_REGION) $(OPT_FUNCTION) $(OPT_TFSTATE) --dry-run

