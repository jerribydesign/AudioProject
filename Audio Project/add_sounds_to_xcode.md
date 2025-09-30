# How to Add Sounds to Your Xcode Project

## Step-by-Step Instructions:

### 1. Open Your Xcode Project
- Open `Audio Project.xcodeproj` in Xcode

### 2. Add the Sounds Folder
1. **Right-click** on your project name in the navigator (left sidebar)
2. **Select "Add Files to 'Audio Project'"**
3. **Navigate to** your project folder: `/Users/jerichosanchez/Desktop/Audio Project/Audio Project/Audio Project/`
4. **Select the `sounds` folder** (the entire folder)
5. **Make sure these options are checked:**
   - ✅ "Create folder references" (NOT "Create groups")
   - ✅ "Add to target: Audio Project"
6. **Click "Add"**

### 3. Verify the Files Are Added
After adding, you should see:
- A `sounds` folder in your Xcode project navigator
- All 16 `.m4a` files listed inside the sounds folder
- Each file should have a checkmark indicating it's included in the target

### 4. Build and Test
- Press **⌘+R** to build and run
- Tap the buttons to hear the sounds!

## Current Button-to-Sound Mapping:

| Button Title | Sound File | Description |
|--------------|------------|-------------|
| Work it | workit.m4a | "Work it" |
| Make it | makeit.m4a | "Make it" |
| Do it | doit.m4a | "Do it" |
| Makes us | makesus.m4a | "Makes us" |
| More than | morethan.m4a | "More than" |
| Hour | hour.m4a | "Hour" |
| Never | never.m4a | "Never" |
| Ever | ever.m4a | "Ever" |
| After | after.m4a | "After" |
| Work it | workit.m4a | "Work it" (duplicate) |
| Harder | harder.m4a | "Harder" |
| Better | better.m4a | "Better" |
| Faster | faster.m4a | "Faster" |
| Stronger | stronger.m4a | "Stronger" |
| Power | power.m4a | "Power" |
| Over | over.m4a | "Over" |
| Background | background.m4a | "Background" |

## Troubleshooting:

### If sounds don't play:
1. **Check file names** - Make sure the file names in the `sounds` folder exactly match the `fileName` in `AudioConfig.swift`
2. **Check file extension** - Make sure all files are `.m4a` format
3. **Check target membership** - In Xcode, select each sound file and verify "Target Membership" shows "Audio Project" is checked
4. **Check console** - Look for error messages in the Xcode console when you tap buttons

### If you want to add more sounds:
1. Add new `.m4a` files to the `sounds` folder
2. Add them to Xcode using the same process
3. Add new entries to the `customSamples` array in `AudioConfig.swift`
