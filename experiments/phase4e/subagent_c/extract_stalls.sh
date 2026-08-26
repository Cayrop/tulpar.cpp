#!/bin/bash
# Extract stall ratio from rocprofv3 results.
for d in rocprof/V0_down rocprof/C1_down rocprof/C2_down rocprof/C3_down rocprof/C4_down \
         rocprof/V0_gateup rocprof/C1_gateup rocprof/C2_gateup rocprof/C3_gateup rocprof/C4_gateup; do
  if [ -f "$d/averages.txt" ]; then
    wait_any=$(grep "SQ_WAIT_INST_ANY" "$d/averages.txt" | cut -d'|' -f2)
    wait_lds=$(grep "SQ_WAIT_INST_LDS" "$d/averages.txt" | cut -d'|' -f2)
    cycles=$(grep "SQ_WAVE_CYCLES" "$d/averages.txt" | cut -d'|' -f2)
    waves=$(grep "SQ_WAVES" "$d/averages.txt" | cut -d'|' -f2)
    insts_lds=$(grep "SQ_INSTS_LDS" "$d/averages.txt" | cut -d'|' -f2)
    insts_valu=$(grep "SQ_INSTS_VALU" "$d/averages.txt" | cut -d'|' -f2)
    insts_tex=$(grep "SQ_INSTS_TEX_LOAD" "$d/averages.txt" | cut -d'|' -f2)
    # Compute stall ratio using bc
    stall=$(python3 -c "print(f'{$wait_any / $cycles:.4f}')")
    cycles_per_wave=$(python3 -c "print(f'{$cycles / $waves:.1f}')")
    insts_valu_per_wave=$(python3 -c "print(f'{$insts_valu / $waves:.1f}')")
    printf "%-25s stall=%s cycles/wave=%-12s valu/wave=%-10s lds=%-12.0f lds_waits=%-10.0f tex=%.2f\n" \
        "$d" "$stall" "$cycles_per_wave" "$insts_valu_per_wave" "$insts_lds" "$wait_lds" "$insts_tex"
  fi
done
