using UnityEngine;
using UnityEditor;
using UnityEngine.UI;

//同时支持在选中物体上右键菜单创建和直接快捷键创建
public class UGUIHotKey
{
    private static GameObject CheckSelection (MenuCommand menuCommand)
    {
        GameObject selectedObj = menuCommand.context as GameObject;
        //若当前不是右键点击物体的操作则看当前选中的物体的情况
        if (selectedObj == null)
            selectedObj = Selection.activeGameObject;
        //当前没有选中物体或者选中的物体不在Canvas之下则返回空，按键不响应。（当然也可以不要求存在Canvas，没有时则先创建一个新的Canvas）
        if (selectedObj == null || selectedObj != null && selectedObj.GetComponentInParent<Canvas> () == null)
            return null;
        return selectedObj;
    }

    [MenuItem ("GameObject/UGUI/Image #&i", false, 6)] //参数意义请查阅API文档，上文有链接，函数中的几个其他接口的调用的含义也有介绍
    static void CreateImage (MenuCommand menuCommand)
    {
        GameObject selectedObj = CheckSelection (menuCommand);
        if (selectedObj == null)
            return;
        // GameObject go = new GameObject ("Image");
        // GameObjectUtility.SetParentAndAlign (go, selectedObj);
        // Undo.RegisterCreatedObjectUndo (go, "Create " + go.name);
        // Selection.activeObject = go;
        // go.AddComponent<Image> ();
    }

    [MenuItem ("GameObject/UGUI/Text #&t", false, 6)]
    static void CreateText (MenuCommand menuCommand)
    {
        GameObject selectedObj = CheckSelection (menuCommand);
        if (selectedObj == null)
            return;
        GameObject go = new GameObject ("Text");
        GameObjectUtility.SetParentAndAlign (go, selectedObj);
        Undo.RegisterCreatedObjectUndo (go, "Create " + go.name);
        Selection.activeObject = go;

        Text t = go.AddComponent<Text> ();
        Font font = AssetDatabase.LoadAssetAtPath ("Assets/ArtSources/Font/xxxx.ttf", typeof (Font)) as Font;
        t.font = font;
        t.fontSize = 24;
        t.alignment = TextAnchor.MiddleCenter;
        t.color = Color.white;
        t.text = "New Text";
        t.rectTransform.sizeDelta = new Vector2 (150f, 30f);
    }
}