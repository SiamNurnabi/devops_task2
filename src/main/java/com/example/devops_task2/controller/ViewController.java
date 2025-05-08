package com.example.devops_task2.controller;

import org.springframework.boot.info.GitProperties;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewController {

    private final GitProperties gitProperties;

    public ViewController(GitProperties gitProperties) {
        this.gitProperties = gitProperties;
    }

    @GetMapping("/home")
    public String showHomePage(Model model) {
        String hostName = System.getenv("HOST_HOSTNAME");
        model.addAttribute("hostName", hostName);
        model.addAttribute("commitId", gitProperties.getCommitId());
        return "home";
    }
}

/*

Solution 2: Pass Hostname as an Environment Variable
When starting the container, pass the host's hostname explicitly:

bash
docker run -e HOST_HOSTNAME=$(hostname) ...
Then read it in Java:

java
String hostname = System.getenv("HOST_HOSTNAME");

*/

/*
Why This Happens
Docker containers have their own isolated network stack and hostname.

The host machine is a separate system from the container's perspective.
*/


/*
Docker provides a special DNS entry to reference the host machine:

java
String hostname = "host.docker.internal"; // Works on Docker Desktop (macOS/Windows)
For Linux hosts, run the container with:

bash
docker run --add-host=host.docker.internal:host-gateway ...
Then use the same Java code:

java
String hostname = "host.docker.internal";
 */