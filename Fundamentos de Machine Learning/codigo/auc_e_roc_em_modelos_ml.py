
#Como plotar uma curva AUC?
from sklearn import metrics                           # Metricas para calcular accuracy score
from sklearn.linear_model import LogisticRegression   # Modelo utilizado
from sklearn.model_selection import train_test_split  # Separa dados de treinamento e teste
from sklearn.datasets import load_breast_cancer       # Carrega o dataset Breast Cancer    
import matplotlib.pyplot as plt                       # Plotagem de gráficos

#Os dados utilizados neste notebook para plotar a curva AUC são oriundos do dataset Breast Cancer, 
#encontrados em https://archive.ics.uci.edu/ml/datasets.php.
# Carregando Breast Cancer Dataset
breast_cancer = load_breast_cancer()
X = breast_cancer.data
y = breast_cancer.target

# Separando o Dataset
X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.33, random_state=44)

# Criando um modelo 
clf = LogisticRegression(penalty='l2', C=0.1)
clf.fit(X_train, y_train)
y_pred = clf.predict(X_test)

# Accuracy
print("Accuracy", metrics.accuracy_score(y_test, y_pred))

#AUC Curve
y_pred_probability = clf.predict_proba(X_test)[::,1]
fpr, tpr, _ = metrics.roc_curve(y_test,  y_pred_probability)
auc = metrics.roc_auc_score(y_test, y_pred_probability)
plt.plot(fpr,tpr,label="LogisticRegression, auc="+str(auc))
plt.legend(loc=4)
plt.show()

#O novo código cria um novo modelo baseado em árvore e plota a AUC da árvore de decisão junto com a AUC do modelo anterior.

from sklearn.tree import DecisionTreeClassifier
clf = DecisionTreeClassifier()
clf.fit(X_train, y_train)
y_pred = clf.predict(X_test)

y_pred_probability = clf.predict_proba(X_test)[::,1]
fpr, tpr, _ = metrics.roc_curve(y_test,  y_pred_probability)
auc = metrics.roc_auc_score(y_test, y_pred_probability)
plt.plot(fpr,tpr,label="DecisionTree, auc="+str(auc))
plt.legend(loc=4)
plt.show()

#O modelo com DecisionTree possui um desempenho inferior ao do LogisticRegression, 
#pois a área sob a curva é menor no segundo modelo.

#Outro modelo bastante utilizado em classificação é o RandomForest.

#O código para adicionar o RandomForest é semelhante ao DesicionTree.

from sklearn.ensemble import RandomForestClassifier
clf = RandomForestClassifier()
clf.fit(X_train, y_train)
y_pred = clf.predict(X_test)

y_pred_probability = clf.predict_proba(X_test)[::,1]
fpr, tpr, _ = metrics.roc_curve(y_test,  y_pred_probability)
auc = metrics.roc_auc_score(y_test, y_pred_probability)
plt.plot(fpr,tpr,label="RandomForest, auc="+str(auc))
plt.legend(loc=4)
plt.show()

#O desempenho do LogistRegression ainda é superior aos demais.
