module("luci.controller.mentohust1", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/mentohust1") then
        return
    end
    if luci.sys.call("command -v mentohust1 >/dev/null") ~= 0 then
        return
    end
    entry({"admin", "services", "mentohust1"},
        alias("admin", "services", "mentohust1", "general"),
        _("MentoHUST"), 10).dependent = true

    entry({"admin", "services", "mentohust1", "general"}, cbi("mentohust1/general"), _("MentoHUST Settings"), 10).leaf = true
    entry({"admin", "services", "mentohust1", "log"}, cbi("mentohust1/log"), _("MentoHUST LOG"), 20).leaf = true
end
