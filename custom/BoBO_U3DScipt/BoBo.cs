using UnityEngine;
using UnityEditor;
using UnityEngine.UI;

 //%代表Ctrl #代表Shift &代表Alt 

public class MenuItems
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

    [MenuItem("BoBO/Particle/CreateParticle %#&1",false, 6)]
    private static void CreateParticle(MenuCommand menuCommand)
    {
        // GameObject selectedObj = CheckSelection (menuCommand);
        // if (selectedObj == null)
        //     return;
        // GameObject go = new GameObject ();
        // GameObjectUtility.SetParentAndAlign (go, selectedObj);
        // Undo.RegisterCreatedObjectUndo (go, "Create " + go.name);
        // Selection.activeObject = go;
        // go.AddComponent<particlesystem> ();

        //创建粒子
        if (Selection.activeGameObject != null)
        {
            ParticleSystem particle = ObjectFactory.AddComponent<ParticleSystem>(Selection.activeGameObject);
        }

    }

    //创建子物体
    [MenuItem ("BoBO/GameObject/Add Child ^n")]  
    private  static void MenuAddChild()  
    {  
        Transform[] transforms = Selection.GetTransforms(SelectionMode.TopLevel | SelectionMode.OnlyUserModifiable);  
      
        foreach(Transform transform in transforms)  
         {  
                GameObject newChild = new GameObject("_BoBOChild");  
                newChild.transform.parent = transform;  
         }
    }  

    [MenuItem ("BoBO/GameObject/Remove Component  未实现")]
    private  static void RemoveComponent() 
        {
        //List lst = new List;

        // for(int i = 0;i < lst.Count;i++)
        // {
        //     Destroy(lst[i].gameObject);

        // }
        }



    [MenuItem("BoBO/Add Camera to Selection")]
    public static void AddDefaultComponentEditor()
    {
        if (Selection.activeGameObject != null)
        {
            Camera camera = ObjectFactory.AddComponent<Camera>(Selection.activeGameObject);
        }
    }
}
