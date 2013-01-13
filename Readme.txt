--------------------------------------------------------------
LMAM-OLMAM Matlab Toolbox
--------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

1) Intoduction

The LMAM-OLMAM Matlab Toolbox is a set of Matlab routines that implement the Levenberg Marquardt with Adaptive Momentum (LMAM) 
and the Optimized Levenberg Marquardt with Adaptive Momentum (OLMAM) algorithms. These are two very efficient second-order 
algorithms for training feedforward neural networks and, in some cases, they have been shown to achieve the best training results on 
standard benchmark datasets ever reported in the neural networks literature.

More details of the algorithms can be found in the following papers by  N. Ampazis, and S. J. Perantonis:

1) "Levenberg-Marquardt Algorithm with Adaptive Momentum for the Efficient Training of Feedforward Networks", in Proceedings 
of International Joint Conference on Neural Networks IJCNN' 2000 , Como, Italy. 

2) "Two Highly Efficient Second Order Algorithms for Training Feedforward Networks",  IEEE Transactions on Neural Networks 
Vol. 13, No. 5, September 2002.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

2) Requirements and Installation

This version of the toolbox requires Matlab versions >= 4.0 and its accompanying Neural Network Toolbox. Note that newer versions 
of Matlab (e.g. Matlab 6.0) may display warning messages about "functions been obsolete". This is due to different core function 
implementations in the newer versions of the Neural Network Toolbox, however, the old implementations still remain in the 
"toolbox/nnet/nnobsolete" subdirectory of your Matlab installation directory. You can get rid of such warning messages by using 
the line "nntwarn off" in your scripts.

To run scripts that call the toolbox's routines you should make sure that the following ".m" files are either in the current directory where Matlab 
looks for scripts or that they are located in a directory which has been added to the matlab path variable. A good choice is the Neural Network 
Toolbox directory of the Matlab installation itself ($MATLAB/toolbox/nnet/nnet):

train_lmam.m
train_olmam.m
tlmam1.m
tlmam2.m
tlmam3.m
tolmam1.m
tolmam2.m
tolmam3.m

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

3) Demo Scripts

The toolbox comes with a set of demo scripts which show how it is possible to utilize the LMAM/OLMAM training routines in the same fashion 
as the standard algorithms of the MATLAB's Neural Network Toolbox. 

These demos make use of the function "bdfread.m" which just reads the training data files provided with this toolbox (in the data subdirectory). 
The data files are stored according to the BILLNET Data Format which is the standard data format supported by our accompanying 
BILLNET Neural Network simulator. BILLNET can be dowloaded from "http://www.iit.demokritos.gr/~vasvir/billnet/billnet.html".

The provided demos are the following:

LMAM demos:

a) "demo_lmam1" : Trains a neural network with no hidden units on the Sonar Data benchmark. 
b) "demo_lmam2" : Trains a neural network with one hidden layer on the 2-Spirals data benchmark. 
Note: This type of network setting is the most common for problem solving since most training tasks can be learned with a single hidden layer.
c) "demo_lmam3":  Trains a neural network with two hidden layers on the 4-Parity data benchmark.

OLMAM demos:

a) "demo_olmam1" : Trains a neural network with no hidden units on the Sonar Data benchmark. 
b) "demo_olmam2" : Trains a neural network with one hidden layer on the 2-Spirals data benchmark.
Note: This type of network setting is the most common for problem solving since most training tasks can be learned with a single hidden layer.
c) "demo_olmam3" : Trains a neural network with two hidden layers on the 4-Parity data benchmark.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

4) Contact

In case that you need assistance with the scripts of the toolbox you can contact Dr Nicholas Ampazis at the following e-mail address: 

n.ampazis@fme.aegean.gr

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------
LMAM-OLMAM Matlab Toolbox
--------------------------------------------------------------
