## Predictor-Estimator models Transfer Learning 

This part of the work is to prepare the best Transfer Learning Perdictor-Estimator model for the whole project. Before running the code, please install python packages based on requirements.txt.


### Instruction (use "strategy 1" as an example)

First, run "combine_19and20.ipynb" ("sample_common.py" and "Ed_wmt.ipynb" are for strategy 2 and 3) to collect "wmt_1920" data("wmt_common" and "wmt_171920" are for strategy 2 and 3). Find the prepared "wmt_1920" data in "strategy 1" folder in Data.zip (there are "strategy 2" and "strategy 3" in Data.zip)

Second, rewrite scripts named train_estimator_target1_1.yaml,...train_estimator_target4_1.yaml(training and development path, parameters, etc.) in the "Experiments" folder. Four target models named model.torch can be collected from "baseline/estimator".

Third, run "using_kiwi.ipynb" and each best model for each target will be saved. The path will be "/run/0/<modelid>/best_model.torch". Put your four different best_model.torch to the "transfer1" folder

Strategy 2 and 3 will follow the same instuction (repeat step 1 to 3)

#### Experiments folder

  - Save parameters of perdictor-Estimator models including strategy 1, strategy 2, and strategy 3 models in scripts
  - Named scripts for strategy 1 train_estimator_target1_1.yaml,...train_estimator_target4_1.yaml. Strategy 2 train_estimator_target1_2.yaml,...train_estimator_target4_2.yaml. Strategy 3 train_estimator_target1_3.yaml,...train_estimator_target4_3.yaml
  - The script will help train transfer learning model and collect best model in using_kiwi.ipynb


#### Data.zip

  - Saved strategy 1, strategy 2, and strategy 3 data
  - Prepared data for Ed_wmt.ipynb, combine_19and20.ipynb and sample_common.py to collect three new different data set


#### oxf3000.csv

  - Used in sample_common.py to prepare wmt_common data in Data.zip


#### target folder

  - referenced to "baseline/estimator" folder. There are 4 model.torch files in each target_1, target_2, target_3, and target4


#### best_model.zip

  - Saved best models for different strategy 1, strategy 2, and strategy 3


#### combine_19and20.ipynb

  - Combined wmt19 and wmt20 all training data together
  - Included .pe, .mt, .tags, .hter, .src files


#### Ed_wmt.ipynb

  - Used fuzzywuzzy to select less likely 2500 sentences in each wmt17, wmt19, and wmt20
  - Included .pe, .mt, .tags, .hter, .src files

#### sample_common.py

  - Prepared common words and select corresponding sentences from wmt19 and wmt20
  - Included .pe, .mt, .tags, .hter, .src files

#### using_kiwi.ipynb

  - Trained three different data set and save the best model
  - Saved our best model to xxxx folder
