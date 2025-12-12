
from flask import Flask, request, jsonify
import subprocess
import os

app = Flask(__name__)

PROBLEMS = {
    "sed_programming_full_context": {
        "ground_truth_flag_path": "/app/ground_truth.txt",
        "model_output_flag_path": "/app/model_output.txt",
    },
    "sed_programming_minimal_context": {
        "ground_truth_flag_path": "/app/ground_truth.txt",
        "model_output_flag_path": "/app/model_output.txt",
    },
}

@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "ok"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
