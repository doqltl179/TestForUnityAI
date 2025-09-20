using UnityEngine;

public class TouchEffectScript : MonoBehaviour
{
    private float lifetime = 1.0f; // Duration of the effect
    private float fadeSpeed = 1.0f; // Speed of fading out
    private UnityEngine.UI.Image image;
    void Start()
    {
        image = GetComponent<UnityEngine.UI.Image>();
        if (image == null)
        {
            Debug.LogWarning("TouchEffectScript requires an Image component.");
            return;
        }

        // Start the fade-out process
        StartCoroutine(FadeOut());
    }

    private System.Collections.IEnumerator FadeOut()
    {
        float elapsedTime = 0f;
        while (elapsedTime < lifetime)
        {
            elapsedTime += Time.deltaTime;
            if (image != null)
            {
                Color color = image.color;
                color.a = Mathf.Lerp(0.5f, 0f, elapsedTime / lifetime); // Fade alpha from 0.5 to 0
                image.color = color;
            }

            yield return null;
        }

        // Destroy the touch effect after fading out
        Destroy(gameObject);
    }
}