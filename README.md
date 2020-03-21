# lambda_layers
Bash scripts to create aws lambda layers for python

This is a simple collection of bash scripts that can save yout life if you want create layers inside aws lambda.
Layers are building blocks of code that can be included in a lambda code. With layers your lambda package can use more and more code and you can exceed limits of space imposed to the code directly pushed in a lambda package. You can read more in the official documentation:
- [What Is AWS Lambda?](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- [AWS Lambda Layers](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html)
- [AWS Lambda Limits](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-limits.html)
- [Hosting your ML model on AWS Lambdas ](https://towardsdatascience.com/hosting-your-ml-model-on-aws-lambdas-api-gateway-part-1-9052e6b63b25)

Scripts contained in this repository has been tested only in a Ubuntu bionic EC2 instance.

Requirements are described in the following sections.

## Getting Started

### Step 1: configuration
Bash scripts in this repository make use of [AWS CLI 2](https://aws.amazon.com/cli/?nc1=h_ls) and Docker.
Inside the `configuration/` directory you can find two scripts with every steps of their installation.

+ **awscli_configuration.sh** is a very simple, two line scripts, from [official documentation]( https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html). It require sudo privileges.
After installing aws cli, you must configure it with credentials of your aws account. You can follow [official documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html), or simply run:
```$ aws configure```

+ **install_docker.sh** is a bit more complex. Commands contained inside this scripts are from 
[docker documentation](#https://docs.docker.com/install/linux/docker-ce/ubuntu/).
Following this code you can easily install docker from official repositories.

### Step 2: create a layer
You can find two example layers (pandas and scikit-learn) and a `clean/` directory, that can be copied to create other layers.
In each of this directories the only file that must be edited is `config.sh`, that contains some variable definitions:
```
LAYER_NAME='layer_pandas_0_25_3.zip'
DESCRIPTION="pandas 0.25.3 for python 3.7.6"

# A LIST OF PACKAGE TO INSTALL, SPACE SEPARATED
PACKAGES="pandas==0.25.3"

RUNTIMES="python3.7"
```

+ `LAYER_NAME` will be used either as the name of the layer during the upload (after basename-ing it) and as the name of the zip file that will be uploaded. My suggestion is to be as explicit as possible and adopt a name that describe the real content of the layer.
+ `DESCRIPTION` is a short text attached to the layer in AWS.
+ `PACKAGES` is a list of python packages that will be installed inside the layer from pip. This string will be directly passed to pip, inside the docker, than you can write here what you normally write as pip list of packages.
+ `RUNTIMES` is one or more from available aws runtimes. If you want change runtimes, you must edit also the script `10_build_layer_from_docker.sh`, that is in charge to run the docker image of the same runtime, and `build_layer_inside_docker.sh`, where the path of the runtime is part of pip install process.

After these steps, you can run:
1. `10_build_layer_from_docker.sh`
2. `20_upload_layer_to_aws.sh`

The first script (download if not already done and) run the docker image that emulate aws lambda environment. The same script ask the image to run the script `build_layer_inside_docker.sh`, which is the core, because contains the `pip install...` command with which python packages are downloaded from pypi and installed in a local directory, and the zip command to create the layer. Also this scipts follows `config.sh` instructions.

After running `10_build_layer_from_docker.sh`, inside the `pandas/` directory you can find the `layer_pandas_0_25_3.zip` file, that is a zip of the dirtree created by pip.

The second script, `20_upload_layer_to_aws.sh` simply run `aws lambda publish-layer-version` whit several options filled from `config.sh`. The stdout of the command are redirected to the upload.log file. Stderr is showed at screen.
