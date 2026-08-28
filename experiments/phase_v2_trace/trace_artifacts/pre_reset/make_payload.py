#!/usr/bin/env python3
"""Generate completion payload for V2 trace arms."""
import json, sys

def make_payload(prompt_tokens_approx: int, n_predict: int = 32) -> str:
    """Generate a prompt of approximately prompt_tokens_approx tokens.
    
    ~1.3 tokens per word, ~6 words per sentence repetition.
    """
    base = "The quick brown fox jumps over the lazy dog. "
    # Rough: 1 sentence ≈ 9 words ≈ 12 tokens
    reps = max(1, (prompt_tokens_approx * 2) // 12)
    prompt = (base * reps).strip()
    
    payload = {
        "prompt": prompt,
        "n_predict": n_predict,
        "temperature": 0,
        "stream": False
    }
    return json.dumps(payload)

if __name__ == "__main__":
    tokens = int(sys.argv[1]) if len(sys.argv) > 1 else 512
    n_pred = int(sys.argv[2]) if len(sys.argv) > 2 else 32
    print(make_payload(tokens, n_pred))
