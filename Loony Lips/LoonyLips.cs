using Godot;
using System;
using System.Collections.Generic;
struct Story {
    public List<String> prompts;
    public String story;
}

public class LoonyLips : Node2D {
    //private instance variable
    Story currentStory;

    //cached references
    RichTextLabel storyText;
    LineEdit textEntryBox;

    public override void _Ready() {
        CacheComponents();
        ShowIntro();
        SetRandomStory();
        //PromptPlayer();
    }

    //Signals
    void OnTextEntry(String entry) { 
        GD.Print("Text Entered: " + entry);
    }

    void TextButtonPressed() {
        GD.Print("Text Button Was Pressed.");
    }
    void CacheComponents() {
        storyText = FindNode("StoryText") as RichTextLabel;
        textEntryBox = FindNode("TextBox") as LineEdit;
    }

    private void ShowIntro() {
        storyText.Text = "It worked!";
        textEntryBox.Text = "BOOM";
    }

    private void SetRandomStory() {
        var parseResult = GetJSONParseResult("stories.json");
        var stories = parseResult.Result as System.Array;
        GD.Print(stories);
        Random rnd = new Random();
        var storyIndex = rnd.Next(0, stories.Length);
    }

    private JSONParseResult GetJSONParseResult(string localFileName) {
        var file = new File(); 
        file.Open(localFileName, 1);  // Mode 1 is read only
        var text = file.GetAsText();
        file.Close();
        var parseResult = JSON.Parse(text);
        if (parseResult.Error != 0)
        {
            GD.Print(localFileName + " parse error");
            return null;
        }
        else
        {
            GD.Print(localFileName + " read OK");
            return parseResult;
        }
    }

}
