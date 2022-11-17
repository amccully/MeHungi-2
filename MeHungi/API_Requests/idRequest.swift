let url = URL(string: "http://127.0.0.1:5000/")

let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in 
  // your code here

    if let error = error {
        print("Error accessing url: /(error)")
        return
    }

    guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(response)")
    return
  }

    do {
        let IDs = try? JSONDecoder().decode(IDs.self, from: data)
    }
    catch {
        print("Whoops!")
    }
    

})

task.resume()

let IDList = IDs.values()