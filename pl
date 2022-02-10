using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Player : MonoBehaviour
{
    private Animator animator;
    private Rigidbody2D rb;

    public bool jump = false;
    public AudioClip clipJump; 

    public Text scoreText;
    int score = 0;

    float speed = 5f;

    public Button Restart;
    public Button Next;

    void Start()
    {
        rb = GetComponent<Rigidbody2D>();
        animator = GetComponent<Animator>();
    }

   
    void Update()
    {
        Move();
        scoreText.text = "Score: " + score.ToString();
    }

    void Move()
    {
        float x = Input.GetAxis("Horizontal");

        rb.velocity = new Vector2(x * speed, rb.velocity.y);

        if ( Input.GetKeyDown("space") && !jump )
        {
            AudioSource.PlayClipAtPoint(clipJump, transform.position);
            rb.AddForce(Vector2.up * 350);
            animator.SetBool("Jump", true);
            jump = true;
        }
        if (rb.velocity.x == 0)
        {
            animator.SetBool("Walk", false);
        }
        else
        {
            animator.SetBool("Walk", true);
        }
        if (rb.velocity.x > 0)
        {
            transform.rotation = new Quaternion(0, 0, 0, 0);
        }
        if (rb.velocity.x < 0)
        {
            transform.rotation = new Quaternion(0, 180, 0, 0);
        }
    }

    private void OnCollisionEnter2D(Collision2D other)
    {
        jump = false;
        animator.SetBool("Jump", false);
    }
    void OnTriggerEnter2D(Collider2D other)
    {
        if(other.gameObject.tag == "Item")
        {
            score++;
            scoreText.text = "Score: " + score.ToString();
            Destroy(other.gameObject);
        }
        if(other.gameObject.tag == "Finish")
        {
            Time.timeScale = 0;
            Next.gameObject.SetActive(true);
        }
    }
}
