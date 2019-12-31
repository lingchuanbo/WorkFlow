
using UnityEngine;
using UnityEditor;
using UnityEngine.UI;

public class BoBO_SetActive
{
    //快捷键可以为%=ctrl/cmd #=shift &=alt LEFT/RIGHT/UP/DOWN F1-F12,HOME END PGUP PGDN _a~_z
    [MenuItem("BoBO/GameObject/SetActive %#&h", false, 11)] //11及以后可以在Camera之后显示
    static void MenuGameObjectSetActive()//通过按a键来设置所选择GameObject的active状态
    {
        Debug.Log("MenuGameObjectSetActive");
        if(Selection.activeGameObject != null)
        {
            Undo.RecordObject(Selection.activeGameObject, "SetActive" + Selection.activeGameObject.activeSelf + " " + Selection.activeGameObject.name);
            Selection.activeGameObject.SetActive(!Selection.activeGameObject.activeSelf);//就算锁定了inpector,也是处理当前选中的
        }
        Debug.Log(Selection.activeObject.name);
    }

    [MenuItem("BoBO/GameObject/SetActive  %#&h", true, 11)]
    static bool CheckIsGameObject()//判断是否显示该菜单的校验方法，如果没选择GameObject为灰
    {
        UnityEngine.Object selectedObject = Selection.activeObject;
        if(selectedObject != null && selectedObject.GetType() == typeof(GameObject))
        {
            Debug.Log(selectedObject.name);
            return true;
        }
        return false;
    }
}