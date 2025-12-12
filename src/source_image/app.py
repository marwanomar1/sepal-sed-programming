from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

CHECKER_PATH = "/app/checker.sed"

@app.route("/check", methods=["POST"])
def check_flag():
    data = request.get_json(force=True)
    user_input = data.get("input", "")

    proc = subprocess.run(
        ["sed", "-f", CHECKER_PATH],
        input=user_input,
        text=True,
        capture_output=True,
        timeout=2
    )

    return jsonify({"result": proc.stdout.strip()})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
