# Development Environment Guide

_This guide is based on the [cs300 lab](https://cs.brown.edu/courses/csci0300/2023/assign/labs/lab0.html) for setting up your development environment._

---

## Introduction

**Docker** is a convenient way to manage virtual environments as "containers." We will be using it to run Ubuntu 22.04 (jammy), a Linux-based operating system. If you've taken CS 300, the container setup will be very similar with a few extra tools preinstalled.

### Why are we using this?

With virtualization, we can specify a standard development environment on any machine, so your code will work no matter where it's run. _(You won't need to log into the CIT department machines to write, test, or hand in your code!)_

---

## Installing Docker and X Server

Your computer is probably running Mac OS, Windows, or Linux. These different _operating systems_ all come with different libraries and preinstalled software. A [**Virtual Machine**](https://www.youtube.com/watch?v=yIVXjl4SwVo) can establish the same software environment for everyone.

> **Note**: Software inside a VM believes it is running on a physical computer, even though it is running within an OS within another computer. Achieving this level of virtualization has costs, including the cost of emulating the underlying hardware.

In this class, we will use a **container**, a technology that emulates an OS without the full
overhead of a VM. The container runs a Linux-based operating system, **Ubuntu**. The autograder also
runs a Linux-based OS, so if your code works in the container, it will work on the autograder.

### Docker

[**Docker**](https://www.docker.com/) is one of the most popular container solutions and widely used in
industry. In CS 1952Y, we use Docker because it lets you run a course container on Windows, Mac OS,
or Linux.

You may download Docker [here](https://www.docker.com/products/docker-desktop). On Linux machines,
follow the instructions [here](https://docs.docker.com/engine/install/ubuntu/).

After downloading Docker, follow Docker’s instructions to install it on your OS. Accept if Docker asks for privileged access.

On Windows or Mac OS, open the Docker Desktop application after it has been installed. You may see a message similar to “Docker Desktop is Starting…”. Once this message goes away, your Docker has started successfully!

Verify Docker is installed by executing the following command in a terminal:

```
$ docker --version
```

A Docker version number should be printed.

After installing Docker, a Docker process (the Docker daemon) will run in the background. Run the following command to verify:

```
$ docker info
```

This should print some information about your Docker installation.

If you see the following error:

```
ERROR: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
```

it means Docker hasn’t started running yet. On Windows or Mac OS, ensure your Docker Desktop is running. On Linux, try the command `sudo systemctl docker restart` in a terminal.

You can follow additional instructions from the [cs300 lab](https://cs.brown.edu/courses/csci0300/2023/assign/labs/lab0.html) if you are on Windows and do not have WSL (Windows Subsytem for Linux) set up yet.

### X Server

X11, or [X Window Subsystem](https://www.wikiwand.com/en/X_Window_System) is a framework that powers
most GUI applications in Linux. Ripes requires a GUI interface, so in order to run it within a
Docker container, we need to connect to a program on the host (the X server) that can draw its
window.

<details>
    <summary><strong>Instructions for Mac OS</strong></summary>
    <p>
    Download and install XQuartz <a href="https://www.xquartz.org/">here</a>. Run the installer and allow the
    app to make changes to your computer when prompted. During installation, you may be asked to log
    out and log back into your computer in order to update your system environment.
    </p>
    <p>
    Once XQuartz is installed, open it from the applications menu. After it opens, navigate to the
    menu bar at the top of your screen and select <strong>XQuartz > Preferences</strong>. Go to the <strong>Security</strong>
    tab and check the box labeled <strong>"Allow connections from network clients"</strong>. This will allow the
    container to connect to your X server.
    </p>
    <p>
    Quit XQuartz by selecting <strong>XQuartz > Quit</strong> from the menu bar. XQuartz should reopen
    automatically when you start the container later.
    </p>
</details>

<details> 
    <summary><strong>Instructions for Windows</strong></summary>
    <p>
    Download and install VcXsrv <a href="https://sourceforge.net/projects/vcxsrv/">here</a>. Run the installer (the
    default options should be fine), and allow the app to make changes to your computer when prompted.
    </p>
    <p>
    After installing VcXsrv, run it from the start menu. If presented with any questions, accept the
    defaults. Once VcXsrv has finished starting, you should see it running in your system tray (bottom
    right corner of the screen).
    </p>
    <p>
    <strong>NOTE: Each time you restart your computer, you will need to start VcXsrv whenever you need to run the container.</strong>
    </p>

</details>

<details>
    <summary><strong>Instructions for Linux</strong></summary>
    <p>
    Linux most likely has an X server already installed so you shouldn't have to do much here!
    Check if you have <code>xhost</code> by running <code>which xhost</code>.
    </p>
    <p>
    If xhost is not found, you will need to install it on your system. On Ubuntu or Debian, you can
    do this by running <code>sudo apt-get install x11-xserver-utils</code>. On other distributions, you will
    need to install a similar package (the name may be different though).
    </p>
    <p>
    Once you have installed xhost, <code>which xhost</code> should print something similar to <code>/usr/bin/xhost</code>.
    </p>
</details>
<br>

---

## Setting Up the Dev Environment

In Docker, an environment is defined as a **Docker image**. An image specifies the operating system
environment that a container provides. An image can also contain additional software dependencies
and configurations. These instructions are specified in a file, the so-called **Dockerfile**.

You will now download the course's setup code and create the CS 1952Y Docker image!

<details>
    <summary><strong> Mac OS only: Install Apple development tools</strong></summary>
    <p>
    If you're running on Mac OS, you will need to install a set of Apple-recommended
    command-line tools via the following command: 
    <pre><code>
    xcode-select --install
    </code></pre>
    This ensures that your computer has installed <code>git</code>, a program we'll use later. Alternatively,
    you may also download and install <code>git</code> directly, following instructions from <a href="https://git-scm.com/download/mac">here</a>.
    </p>
</details>
<br>

Do the following to set up your development environment.

1. Enter the directory on your computer where you want to do your coursework. For Windows users,
   choosing somewhere in the C drive will make the following steps easier.

    Then, enter the following command to download our [development environment](https://github.com/browncs1952y/cs1952y-s24-devenv.git) to the new
    subdirectory `DEV-ENVIRONMENT` (you can choose your own name, `DEV-ENVIRONMENT` is a placeholder!):

    ```
    $ git clone https://github.com/browncs1952y/cs1952y-s24-devenv.git DEV-ENVIRONMENT
    ```

    This command clones a Github repository onto your computer.

2. Run `cd DEV-ENVIRONMENT` to enter the directory you have just created
3. Inside this folder, do the following:

   ```
   $ ./docker/cs1952y-setup-docker
   ```

    This will attempt to pull our Docker image that has been prebuilt. If you wish to do so,
    `./docker/cs1952y-build-docker` will build the image from scratch (this can take up to 20 minutes).

    The setup script _should_ tag the image correctly, but if it doesn't (you get an error saying the image was not found), you can also tag it manually:

    ```
    $ arch=$([ $(arch) = arm64 ] && echo "arm64" || echo "latest") && docker tag mramesh5/cs1952y:$arch cs1952y:$arch
    ```

4. After this, you can run Docker for the first time:
   ```
   $ ./cs1952y-run-docker
   ```
   You can now interact with the shell of the container. You can use `Ctrl-D` to exit

### Shared Folders

“If my docker container is a separate (virtual) computer than my laptop, how will I move files between the two?”, you may ask. Great question! You’ll move files between the two in any of the ways you can move files between any two computers! (Bear with us!)

To get files to and from department machines, you may have used things like `scp`, `sftp`, and **Cyberduck**, which allow you to copy files over the network. These work, but are inconvenient if you’re constantly moving them back and forth.

If you’re lucky, you may have been exposed to **FUSE** and `sshfs`, which allow you to mount a filesystem over the network. This allows your computer to navigate the remote files as if they were stored locally, which means any changes you make are happening on both ends automatically.

Inside of the container, your home directory (`/home/cs1952y-user`, or `~`) is actually a mount of the home directory inside your `DEV-ENVIRONMENT` directory. Any changes you make in one will be visible in the other.

<details>
    <summary><strong>If you move or rename your dev-environment folder</strong></summary>
    <p>
    Your Docker container will still try to mount to the original dev-environment path, even after you rename, remove, or move the folder <code>DEV-ENVIRONMENT</code>.
    </p>
    <p>
    After moving your dev-environment folder, you’ll need to delete the old container and start a new container. You can do so with
    <code>./cs300-run-docker --clean</code>.
    You should be able to enter a container, and see all of your work now!
    </p>
</details>

<details>
    <summary><strong>If you have filesystem sync issues on Mac OS</strong></summary>
    This might be caused by gRPC FUSE, which is sometimes buggy on MacOS. Go into your docker settings and make sure that the gRPC FUSE checkbox is not checked, or that the sync method is set to <code>VirtioFS</code>.
</details>
<br>

---

## Text Editors and IDEs

What development environment or editor to use is a question that divides people and has led to countless hours being wasted on heated discussion, offline and online for decades. Some people prefer very simple editors that run in their terminal, while others prefer graphical integrated development environments (**IDEs**). For CS 1952Y, we don’t really care what you use – if it works for you, great!

To make your life easier, however, you probably want to use an editor with syntax highlighting for C++, the main programming language we’ll use in CS 1952Y.

You can edit your source code inside the course container, or on your normal operating system. Recall that the home directory inside the container is a mount of your local `cs1952y/home` directory (or whatever you named it). This means that you can install any editor or IDE of your choice on your **local machine**, edit your files and work on your assignments locally, and all of your changes will be reflected in your container! You can then compile, build, and run your assignments inside your container. This is the power of mounting :fire:!

There are plenty of great choices for text editors. If you’re not sure which one to install, we recommend [VSCode](https://code.visualstudio.com/). It has very nice integration with our Docker container, and it’s nicely customizable with extensions.

<details>
    <summary><strong>How to link VSCode with the course Dev Environment</strong></summary>
    <ol>
    <li>Download and install VSCode on your computer (not the course container) normally</li>
    <li>Navigate to the extensions tab by clicking this icon on the left side of the screen: 
    <br><img src="https://i.imgur.com/x7Nedgs.png">
    </li>
    <li>Search for and install the "Docker", "Dev Containers", and "WSL" VSCode extensions via the extensions tab</li>
    <li>Make sure your course container is running (either by connecting to it, or checking the docker desktop app)</li>
    <li>Click the green button in the bottom left of VSCode, then click "Attach to running container" and select your CS1952Y course container
    <br><img src="https://microsoft.github.io/vscode-remote-release/images/remote-dev-status-bar.png">
    </li>
    <li>You can now open any folder you want to edit, and can get a terminal from your course container by clicking View > Terminal</li>
    </ol>
</details>
<br>

---

## Installing programs on Linux (in your course container)

Our containers come with a few programs pre-installed, but what if we want more? With a text-based interface like the command line, it’s quite difficult to navigate the web and find a suitable download link. Instead, we use a program called a package manager which can automatically download, install, and update programs. We’ll be using a manager called `apt`. `apt` can install many things, including tools to build (or compile), and debug your code. Our containers already come with these tools for your convenience.

As an example, to install fortune, you would run

```
$ sudo apt update
$ sudo apt install fortune
```
