# Docker IPVLAN

Since I began to write code, the fact of using the standard `localhost` plus the ever growing number of ports assigned to what ever service might be running at the time; to me was somewhat unsustainable.
To say the least it was alien and not at all how the internet was supposed to work. It took me a while to understand that the reason you never see `:80` or `:443` on the browser was because those ports are the default for `http` and `https` services respectively. However, my mind could not get past the fact that in order to maintain services, I would also have to maintain a list of all the port numbers that were already in use.

## Reverse Proxies

It was not long until I came across my first breakthrough and was introduced into reverse proxies. I might have spent a day or two with Apache servers since at that time I owned a Macbook and even though at college I learnt how to do C/C++ programs, since I was not a computer science major I never really got to do more than compiling and running for the various projects we had deliver.
When I first started with web development something inside me was ignited and for the first time I had a good look at how one could create something extremely visual out of pure text. Since I was still Apple bound there was little to no option than to dig into the `MAMP` stack, which I came to dislike very quickly. The XML format of Apache configuration files, although somewhat similar to HTML syntax was not for me; I was more inclined to a structure/object/JSON style.
The already installed Apache server on the Apple devices gave lots of headaches, specially whenever there were system updates (and there were tons of them) everything just stopped working and I had to go back to the beggining to continue with whatever bullshit I was trying to accomplish back then. 

## Nginx

Allthough it took me a while to stumble upon `nginx` and a way more to get the grasp of what was going on, I quickly fell in love with what seemed to me a more simple approach to writing server configuration files. All the endless nights I had spend battling with Apache had now became more productive.
First framework I came accross was `Laravel` and now I could just spin projects up, add them to my nginx config files and tweak the `/etc/hosts` file and have something I was more familiar with. Even though this could not be farther from what I really wanted I felt it was a step in the right dirrection.
My mind how ever still was unable to comprehend why I was not able to assign a different IP address to these Laravel applications that I was constantly spinning up, but rather relied on assiging a port to each one, then creating a reverse proxy in nginx that pointed to that port and finally change the hosts file; which quicky became plagued by a swarm of `127.0.0.1 [APP_NAME]` rows.
Just like that what I had previously felt all of the sudden became another bug in my head I could not get rid off.

## Virtualisation

This might have been the most confusing era of the journey I felt had taken full controll of my everyday train of thought. At that time upon reading Laravel's documentation I came accross an inner project, Homestead; a Vagrant Box designed for the sole purpose of running these applications.
I'm not able to  recall how I managed to get things to work as I did not spend as much time as I would have liked with Vagrant, VirtualBox or any other virtualisation driver that was enabled.
I do remember however that the amount of memory these Virtual spaces were taking on my 250GB Macbook was extremely high and even though this was my first time actually assigning an IP address to something inside my computer, I soon realized that the way I imagined things was not sustainable at all. 

# Docker

Soon after learning about Vagrant a new technology had taken over the whole virtualization stack. I learnt about Laravel Sail and once I began researching for any information about it I quickly came to find that Sail was just a shell script to manage one Docker container and a whole lot of people were discouraging others from using Laravel Sail since it would not allow you to understand the true nature and power of Docker, plus 
