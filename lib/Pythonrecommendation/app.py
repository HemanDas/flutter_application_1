from flask import Flask, jsonify, request
import pandas as pd
import numpy as np
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.feature_extraction.text import CountVectorizer
import tensorflow as tf

app = Flask(__name__)

df = pd.read_csv('fitness_exercises.csv')
df=df[['name','bodyPart','equipment','target']]
df.set_index('name',inplace=True)

df['combined word']=''
columns=df.columns
for index, row in df.iterrows():
  words=''
  for col in columns:
    if col !='target':
      words=words+''.join(row[col])+' '
    else:
      words=words+row[col]+' '
  row['combined word']=words
df.drop(columns=[col for col in df.columns if col!= 'combined word'],inplace=True)

# Assuming that df is a pandas DataFrame containing the 'combined word' column
combined_word = df['combined word']

# Create a CountVectorizer object
count = CountVectorizer()
count_matrix = count.fit_transform(combined_word)

# Convert the sparse matrix to a TensorFlow dense tensor
count_matrix = tf.constant(count_matrix.toarray(), dtype=tf.float32)

# Compute the cosine similarity using TensorFlow
cosine_sim = tf.matmul(count_matrix, count_matrix, transpose_b=True)
cosine_sim /= tf.matmul(tf.norm(count_matrix, axis=1)[:, tf.newaxis], tf.norm(count_matrix, axis=1)[:, tf.newaxis], transpose_b=True)
# Print the cosine similarity matrix
indices=pd.Series(df.index)
cosine_sim=cosine_sim.numpy()

def recommendation(title, cosine_sim=cosine_sim):
    # Find the index of the input exercise
    idx = indices[indices == title].index[0]

    # Compute the cosine similarity between the input exercise and all other exercises
    sim_scores = list(enumerate(cosine_sim[idx]))

    # Sort the exercises by their similarity scores, in descending order
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)

    # Get the indexes of the top 10 similar exercises
    top_indexes = [i[0] for i in sim_scores[0:9]]

    # Create a DataFrame with the recommended exercises
    recommended_exercises = df.iloc[top_indexes]
    recommended_exercises=recommended_exercises.drop(columns=['combined word'])
    # recommended_exercises.loc[:,'Similarity Score'] = [i[1] for i in sim_scores[0:11]]
    # recommended_exercises = recommended_exercises.sort_values('Similarity Score', ascending=False)
   
    return recommended_exercises

@app.route('/recommendation', methods=['GET'])
def get_recommendation():
    inputrecommendationchar= str(request.args['recom'])
    recommendation_list = recommendation(inputrecommendationchar)
    return jsonify(recommendation_list.to_dict(orient='Index'))
if __name__ == '__main__':
    app.run(debug=True)
