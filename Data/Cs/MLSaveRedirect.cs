// Redirects the save data to mods/GameData

[HarmonyLib.HarmonyPatch(typeof(Application), "persistentDataPath", HarmonyLib.MethodType.Getter)]
public static class PersistentDataPathPatch
{
    public static bool Prefix(ref string __result)
    {
        string exeDir = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
        string dataPath = Path.Combine(exeDir, "GameData");

        if (!Directory.Exists(dataPath))
            Directory.CreateDirectory(dataPath);

        __result = dataPath;
        return false;
    }
}