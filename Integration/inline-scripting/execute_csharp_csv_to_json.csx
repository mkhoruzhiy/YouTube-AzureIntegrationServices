#r "Newtonsoft.Json"
#r "Microsoft.Azure.Workflows.Scripting"
#r "System.Collections"

using Newtonsoft.Json.Linq;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Azure.Workflows.Scripting;
using Microsoft.Extensions.Logging;

public static async Task<Results> Run(WorkflowContext context, ILogger log)
{
    JToken triggerOutputs = (await context.GetTriggerResults().ConfigureAwait(false)).Outputs;
    var csvData = triggerOutputs?["body"]?["csvData"]?.ToString();
    var lines = csvData.Split('\n');
    var headers = lines[0].Split(',');
    var list = new List<Dictionary<string, string>>();

    foreach(var line in lines.Skip(1))
    {
        var values = line.Split(',');
        var dict = new Dictionary<string, string>();
        for(int i = 0; i < headers.Length; i++)
            dict[headers[i]] = values[i];
        list.Add(dict);
    }

    return new Results
    {
        ConvertedCsv = Newtonsoft.Json.JsonConvert.SerializeObject(list)
    };
}

public class Results
{
    public string ConvertedCsv { get; set; }
}
