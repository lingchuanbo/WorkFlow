using UnityEngine;
using System.Collections;
using UnityEditor;

namespace BSGTools {
	namespace EditorUtilities {
		public class ZeroAll : Editor {
			[MenuItem("BoBO/Reset/Zero All %&a")]
			static void ResetAll() {
				GameObject[] selection = Selection.gameObjects;
				if(selection.Length < 1)
					return;

				Undo.RecordObjects(selection, "Zero All");
				foreach(GameObject go in selection) {
					InternalZeroPosition(go);
					InternalZeroRotation(go);
					InternalZeroScale(go);
				}

				ShowNotification(string.Format("Zero-All on {0} objects", Selection.gameObjects.Length));
			}

			[MenuItem("BoBO/Reset/Zero Position %&z")]
			static void ZeroPosition() {
				GameObject[] selection = Selection.gameObjects;
				if(selection.Length < 1)
					return;

				Undo.RecordObjects(selection, "Zero Position");
				foreach(GameObject go in selection)
					InternalZeroPosition(go);
				ShowNotification(string.Format("Zero-Position on {0} objects", Selection.gameObjects.Length));
			}

			[MenuItem("BoBO/Reset/Zero Rotation %&r")]
			static void ZeroRotation() {
				GameObject[] selection = Selection.gameObjects;
				if(selection.Length < 1)
					return;

				Undo.RecordObjects(selection, "Zero Rotation");
				foreach(GameObject go in selection)
					InternalZeroRotation(go);
				ShowNotification(string.Format("Zero-Rotation on {0} objects", Selection.gameObjects.Length));
			}

			[MenuItem("BoBO/Reset/Zero Scale %&s")]
			static void ZeroScale() {
				GameObject[] selection = Selection.gameObjects;
				if(selection.Length < 1)
					return;

				Undo.RecordObjects(selection, "Zero Position");
				foreach(GameObject go in selection)
					InternalZeroScale(go);

				ShowNotification(string.Format("Zero-Scale on {0} objects", Selection.gameObjects.Length));
			}

			private static void InternalZeroPosition(GameObject go) {
				go.transform.localPosition = Vector3.zero;
			}
			private static void InternalZeroRotation(GameObject go) {
				go.transform.localRotation = Quaternion.Euler(Vector3.zero);
			}
			private static void InternalZeroScale(GameObject go) {
				go.transform.localScale = Vector3.one;
			}

			static void ShowNotification(string message) {
				if(SceneView.currentDrawingSceneView != null)
					SceneView.currentDrawingSceneView.ShowNotification(new GUIContent(message));
				Debug.Log(message);
			}
		}
	}
}