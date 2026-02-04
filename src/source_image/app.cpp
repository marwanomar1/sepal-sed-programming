#include <httplib.h>
#include <nlohmann/json.hpp>
#include <cstdio>
#include <cstdlib>
#include <string>
#include <sstream>

using json = nlohmann::json;

static const char* CHECKER_PATH = "/app/checker.sed";

std::string run_sed(const std::string& input) {
    std::string cmd = "echo \"" + input + "\" | sed -f " + CHECKER_PATH;
    std::array<char, 256> buffer{};
    std::string result;

    FILE* pipe = popen(cmd.c_str(), "r");
    if (!pipe) return "";

    while (fgets(buffer.data(), buffer.size(), pipe)) {
        result += buffer.data();
    }
    pclose(pipe);
    return result;
}

int main() {
    httplib::Server server;

    server.Post("/check", [](const httplib::Request& req, httplib::Response& res) {
        json request_json = json::parse(req.body, nullptr, false);
        std::string user_input = request_json.value("input", "") + "\n";

        std::string output = run_sed(user_input);

        json response;
        response["result"] = output;

        res.set_content(response.dump(), "application/json");
    });

    server.listen("0.0.0.0", 8000);
    return 0;
}
