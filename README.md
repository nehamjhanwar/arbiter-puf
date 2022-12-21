#  MPW8 : ARBITER PUF

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)


 


In cryptography and within embedded security ICs, the PUF is used to create keys that are generated on-demand and instantaneously erased once used. PUF is dependent on random physical factors (unpredictable and uncontrollable) that exist natively and/or are incidentally introduced during a manufacturing process.

Introduction:Arbiter PUFs. utilize the intrinsic timing differences of two symmetrically designed paths to a. single bit of the response at the output of the circuit 

![image](https://user-images.githubusercontent.com/101010093/208838060-4411eeca-1ad9-4192-83a0-63891747bd52.png)
fig: Arbiter PUF

working Principle:Arbiter-based Physically Unclonable Function (PUF) is one kind of the delay-based PUFs that use the time difference of two delay-line signals. 
 ![image](https://user-images.githubusercontent.com/101010093/208838406-ae22c3fe-435d-4a82-bf05-c152d96c4a63.png)

