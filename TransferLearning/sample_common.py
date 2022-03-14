import pandas as pd

common_thres = 0.5
hter_thres = 0

train_folder = ["en-de/train/train", "task1_en-de_traindev/train/train"]
dev_folder = ["en-de/dev/dev", "task1_en-de_traindev/dev/dev"]
train_output_folder = "common/train/train"
dev_output_folder = "common/dev/dev"
dict_path = "oxf3000.csv"

for tf in train_folder:
    src_path = "{}.src".format(tf)
    hter_path = "{}.hter".format(tf)
    mt_path = "{}.mt".format(tf)
    pe_path = "{}.pe".format(tf)
    src_tags_path = "{}.source_tags".format(tf)
    src_mt_path = "{}.src-mt.alignments".format(tf)
    tags_path = "{}.tags".format(tf)

    mapping = pd.read_csv(dict_path)
    s = set(mapping['English'].str.lower())

    df = pd.DataFrame(columns=list('sentence'))

    sentence_cnt, candidate_cnt = 0, 0

    with open(src_path, 'r') as f, open(hter_path, 'r') as f1, \
        open(mt_path, 'r') as f2, open(pe_path, 'r') as f3, \
        open(src_tags_path, 'r') as f4, open(src_mt_path, 'r') as f5, \
        open(tags_path, 'r') as f6, \
        open(train_output_folder + ".src", 'a') as w0, open(train_output_folder + ".hter", 'a') as w1, \
        open(train_output_folder + ".mt", 'a') as w2, open(train_output_folder + ".pe", 'a') as w3, \
        open(train_output_folder + ".source_tags", 'a') as w4, open(train_output_folder + ".src-mt.alignments", 'a') as w5, \
        open(train_output_folder + ".tags", 'a') as w6:
        for line in f:
            common_cnt, total_cnt = 0, 0
            l1 = f1.readline()
            l2 = f2.readline()
            l3 = f3.readline()
            l4 = f4.readline()
            l5 = f5.readline()
            l6 = f6.readline()
            for w in line.split(" "):
                if w.isdecimal():
                    continue
                if w.lower() in s:
                    common_cnt += 1
                total_cnt += 1
            if common_cnt/total_cnt > common_thres and float(l1) >= hter_thres:
                candidate_cnt += 1
                w0.write(line)
                w1.write(l1)
                w2.write(l2)
                w3.write(l3)
                w4.write(l4)
                w5.write(l5)
                w6.write(l6)
            sentence_cnt += 1

    print("Found {} sentences out of {}".format(candidate_cnt, sentence_cnt))

cnt = 0
with open("{}.src".format(train_output_folder), 'r') as f:
    for line in f:
        cnt+=1
print("check train output... {} lines detected".format(cnt))

for devf in dev_folder:
    src_path = "{}.src".format(devf)
    hter_path = "{}.hter".format(devf)
    mt_path = "{}.mt".format(devf)
    pe_path = "{}.pe".format(devf)
    src_tags_path = "{}.source_tags".format(devf)
    src_mt_path = "{}.src-mt.alignments".format(devf)
    tags_path = "{}.tags".format(devf)

    mapping = pd.read_csv(dict_path)
    s = set(mapping['English'].str.lower())

    df = pd.DataFrame(columns=list('sentence'))

    sentence_cnt, candidate_cnt = 0, 0

    with open(src_path, 'r') as f, open(hter_path, 'r') as f1, \
        open(mt_path, 'r') as f2, open(pe_path, 'r') as f3, \
        open(src_tags_path, 'r') as f4, open(src_mt_path, 'r') as f5, \
        open(tags_path, 'r') as f6, \
        open(dev_output_folder + ".src", 'a') as w0, open(dev_output_folder + ".hter", 'a') as w1, \
        open(dev_output_folder + ".mt", 'a') as w2, open(dev_output_folder + ".pe", 'a') as w3, \
        open(dev_output_folder + ".source_tags", 'a') as w4, open(dev_output_folder + ".src-mt.alignments", 'a') as w5, \
        open(dev_output_folder + ".tags", 'a') as w6:
        for line in f:
            common_cnt, total_cnt = 0, 0
            l1 = f1.readline()
            l2 = f2.readline()
            l3 = f3.readline()
            l4 = f4.readline()
            l5 = f5.readline()
            l6 = f6.readline()
            for w in line.split(" "):
                if w.isdecimal():
                    continue
                if w.lower() in s:
                    common_cnt += 1
                total_cnt += 1
            if common_cnt/total_cnt > common_thres and float(l1) >= hter_thres:
                candidate_cnt += 1
                w0.write(line)
                w1.write(l1)
                w2.write(l2)
                w3.write(l3)
                w4.write(l4)
                w5.write(l5)
                w6.write(l6)
            sentence_cnt += 1

    print("Found {} sentences out of {}".format(candidate_cnt, sentence_cnt))

cnt = 0
with open("{}.src".format(dev_output_folder), 'r') as f:
    for line in f:
        cnt+=1
print("check dev output... {} lines detected".format(cnt))