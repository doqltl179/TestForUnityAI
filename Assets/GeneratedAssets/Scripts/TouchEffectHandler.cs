using UnityEngine;
using UnityEngine.EventSystems;

public class TouchEffectHandler : MonoBehaviour
{
    public GameObject touchEffectPrefab;
    public GameObject touchEffectCanvas;
    void Update()
    {
        if (Input.GetMouseButtonDown(0) && !EventSystem.current.IsPointerOverGameObject())
        {
            Vector3 touchPosition = Input.mousePosition;
            CreateTouchEffect(touchPosition);
        }
    }

    private void CreateTouchEffect(Vector3 screenPosition)
    {
        if (touchEffectPrefab != null && touchEffectCanvas != null)
        {
            GameObject touchEffect = Instantiate(touchEffectPrefab, touchEffectCanvas.transform);
            touchEffect.transform.position = Camera.main.ScreenToWorldPoint(new Vector3(screenPosition.x, screenPosition.y, Camera.main.nearClipPlane));
            Destroy(touchEffect, 1.0f); // Destroy the effect after 1 second
        }
    }
}