
# Transfer Learning of Translation Quality Estimation Models

This project applies three transfer learning strategies to the winning baseline Translation Quality Estimation Model for WMT18
for OPENKIWI official baseline https://unbabel.github.io/OpenKiwi/reproduce.html. The baseline work is an ensemble models, which includes NuQe, APE and 4 Predictor-Estimator based models. Transfer learning is only applied to the Predictor-Estimator based models in the baseline work.

A reproduced ensemble models structure of submitted WMT18 work is as following:
![This is an image](https://github.com/CodyDeepPlay/QE_project/blob/main/sentence_level_QE.png)

Due to the limit of the large file saving on github, all the trained/transfer learned models are saved in a google drive location. The models include 'baseline', 'transfer1', 'transfer2', 'transfer3'.
Refer to the link:
https://drive.google.com/drive/folders/1Pv_gOWBD-6agjQIcRD8_30cU97kSnsQv?usp=sharing

The three strategies of transfer leraning are based on different data selections.
1. Use all WMT19 and WMT20 data training data set to transfer learn the baseline model. 
2. Selectively sample sentence pairs from WMT19 abd WMT20 data sets using common words based methods. 
3. Selectively sample sentence pairs from WMT17, 19 and 20 data sets using sentence level similarity based methods. 


All the evaluation of baseline model or transfer learned models are using the WMT18 dev dataset. 


## Getting Started:
### About your computer environment
- This repository has been tested on python 3.7.
- Please install necessasry python packages lised in 'requirements.txt'.
- Open terminal (mac) or command prompt (windows) in your computer.
- Clone our repository. 
  In terminal or command prompt window, type the following command:
```
  git lfs clone https://github.com/CodyDeepPlay/QE_project.git
```
  Please be aware we are using git large file storage (lfs). Due to the big size of multiple baseline and transfer learned models, the clone dowloading process might take up to 10 min. 
  

### 'project.ipynb' file
This is the main file to run. 
- IMPORTANT NOTES
-- We recommend the user to run the notebook CELL BY CELL, as the process of running baseline and transfer learned models' evaluation can take up to several minutes to complete, respectively.  
-- After finishing downloading the repository, if the user has already run the entire notebook once and assume user wants to re-run the script to evaluate models from new experiments, the user will need to delete this 'predictions_baseline' folder. Because each time after running the evaluation script, it will generate such a new folder with the same name 'predictions_baseline' .

Below are general information for this ipython notebook file.
The first half of the notebook is conducting evaluation of the baseline model. The second half of the notebook is conducting evaluation of transfer learned models. 
The key steps of using this notebook is highlighted as below:
  - Perform precitions and evaluations for baseline model, as well as transfer 1, transfer 2, and transfer 3 models using three different strategies.
  - Each transfer learning strategy will generate 4 different transfer learned Predictor-Estimator based models. For example, using strategy 1, transfer learning will generate 4 different models, and the four different models should be saved in folders 'transfer1/estimator/target_1' , 'transfer1/estimator/target_2', 'transfer1/estimator/target_3' and 'transfer1/estimator/target_4', respectively.


### 'baseline' folder
Contains all the models from the baseline work submitted in WMT18, see description at the begining of this README file.

### 'data' folder
Contains the sentence level and word level data from WMT18 that will be used in this project. 


### 'TransferLearning' folder
Contains data and code to generate transfer learning data sets and conduct transfer learning experiments. For more details, please refer to 'README' file in 'TransferLearning' folder.  




## Work flow of repreduce the work in this repository
- Baselie model evaluation:
  - In terminal or command window, nativate to the within the 'QE_project' folder.
  - Run the ipython note book from begining to the section of evaluate baseline model. Again, we recommend user to run the note book CELL BY CELL. 
  - After run the notebook, it will generate a folder, called 'predictions_baseline', to store predication results.
ATTENTION: if want to re-run the script to evaluate new models, you will need to delete this 'predictions_baseline' folder, because each time after running the evaluation, it will generate a new such folder with the same name 'predictions_baseline' .


- Conduct transfer learning and evaluation:
  - Transfer learn the model
  
  Follow the 'README' file in 'TransferLearning' folder. Conduct transfer learning experiment by using strategy 1, 2 or 3. 
  
  - Save transfer learned models into related folders

    - transfer learned models using strategy 1 should be saved into 'transfer1/estimator/target_1' ; 
    - transfer learned models using strategy 2 should be saved into 'transfer1/estimator/target_2' ; 
    - transfer learned models using strategy 3 should be saved into 'transfer1/estimator/target_3'.
    
  - Evaluate transfer learned models
  
  Follow the instructions in 'project.ipynb' to evalue the performance of related transfer learned models.

