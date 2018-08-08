---
title: "First Golang Meetup"
date: 2018-07-22T17:37:00+05:30
draft: false
---

Saturday 21-July-2018, was the first meetup of Gurgaon Golang meetup and also my first Golang meetup. Organised at [Grofers](https://grofers.com) Headquater, Gurgaon for all the gophers in Delhi-NCR.

![Group Photo](img/highres_473080962.jpeg)

Everybody was already half way through the Q/A session when I reached (I was late). Kasisnu was giving a demo of an exercise from the Go book (TCP server that periodically writes the time). You can read the source code of the Exercise from [here](https://github.com/adonovan/gopl.io/blob/master/ch8/clock1/clock.go).

The very first Talk was given by [Alkesh Shrivastava](https://alkeshsrivastava.com) on Goroutines which I failed to attend. You can refer this [doc](https://docs.google.com/presentation/d/1AMyzIe1MrXT8iaCvec0xT2QFg1WF3se2ttFxusJLvzE/edit#slide=id.g33148270ac_0_143) for reference. Since it was the very first meetup, introductions are a good way to start. One by one, everyone including the hosts and attendees, everyone gave a brief introduction about themself.
During introductions, [Melvin](https://twitter.com/melvinodsa) talked about his experience with Golang in industry. [Kasisnu](https://twitter.com/kasisnu) shared his experience with Golang. Kasisnu shared some useful information about the meetup, like the slack channel of Gurgaon-Golang-Meetup(you can join from [here](https://goo.gl/Kck92M)) where the discussions will take place.

It was networking break, Grofers provided us with pizzas and cold-drinks and to keep the fun going.There was also a quiz with prize for the winner. The attendees were asked to solve the problems of [this repository](https://github.com/kasisnu/golang-meetup-1) and the people with PRs would be given prize, isn't it interesting? Experienced **The Best networking** while sharing pizza and discussing the solutions of the problem.  
After the break, when everyone was done with there snacks it was lightning sessions’ turn.Lightening session given by [Yash Mehrotra](https://yashmehrotra.com) who introduced us to Grofers' [go-codon](https://github.com/grofers/go-codon) which generates Go server code from a combination of REST and Workflow DSLs. The concept was fairly new to me but people were excited to know about it.All we have to do is place swagger specification for all our upstream APIs in the folder _spec/clients_ in config.yml format and then these will be converted to client libraries. For more detailed explaination refer this [wiki](https://github.com/grofers/go-codon/wiki)

For a surprize, we had another round of pizzas for everyone (because of our humble host Kasisnu). While everyone was excited about it [Madhukar Mishra](https://www.linkedin.com/in/madhukar-mishra-b55593b8) began with his talk  on Go's concurrency model. Stating with first and foremost misunderstanding, _Concurrency is not Parallelism_ refer [this talk](https://vimeo.com/49718712) for clear insite. Go follows **communicating sequential processes**(CSP) model of concurrency which requires:
 * concurrently executing entities
 * communicating by sending “messages” to each other
A very basic and easy example to understand this model is by looking at \*NIX pipes. To help in understanding the go concurrency let's go through some examples.
{{< highlight golang >}}
func main() {
    boring("boring!")
}

func boring(msg string) { //a very boring function that runs forever like a boring party guest
    for i := 0; ; i++ {
        fmt.Println(msg, i)
        time.Sleep(time.Duration(rand.Intn(1e3)) * time.Millisecond) //random sleep interval
    }
}
{{< /highlight >}}
The _go_ statement runs the function as usual, but doesn't make the caller wait.
It launches a goroutine. 
{{< highlight golang >}}
func main() {
    go boring("boring!")
    fmt.Println("I'm listening.")
    time.Sleep(2 * time.Second)
    fmt.Println("You're boring; I'm leaving.")
}
{{< /highlight >}}

What is a goroutine? It's an independently executing function, launched by a go statement. It has its own call stack, which grows and shrinks as required. It's very cheap. It's practical to have thousands, even hundreds of thousands of goroutines. It's not a thread. There might be only one thread in a program with thousands of goroutines.Instead, goroutines are multiplexed dynamically onto threads as needed to keep all the goroutines running. The above _boring_ example cheated.the main function couldn't see the output from the other goroutine. It was just printed to the screen, where we pretended we saw a conversation. Now comes **channels**, a channel in Go provides a connection between two goroutines, allowing them to communicate. For example :
{{< highlight golang >}}
func main() {
    c := make(chan string)
    go boring("boring!", c)
    for i := 0; i < 5; i++ {
        fmt.Printf("You say: %q\n", <-c) // Receive expression is just a value.
    }
    fmt.Println("You're boring; I'm leaving.")
}
func boring(msg string, c chan string) {
    for i := 0; ; i++ {
        c <- fmt.Sprintf("%s %d", msg, i) // Expression to be sent can be any suitable value.
        time.Sleep(time.Duration(rand.Intn(1e3)) * time.Millisecond)
    }
}
{{< /highlight >}}
After the intense discussions on Goroutines it was time for the closing session. The quiz that Kasisnu initiated had prize too, the first three people to make pull request were awarded a golang book. So the meetup ended with a stickers, return gifts(wow!) and lots of new friends and people to learn from. Hope you have enjoyed it and would join us at the [next meetup](https://www.meetup.com/Gurgaon-Go-Meetup).
