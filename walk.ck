fun int walk_dis_to_step( int x , int len)
{
    0 => int step;
    0 => int dis;
    while(dis < x)
    {
        dis + len => dis;
        step++;
        if(step != 0 && step % 5 == 0)
        {
            dis - len * 2 => dis;
        }
    }
    return step;
}

fun float walk_step_to_dis( int x , int len)
{
    x / 5 * 2 => int deduct;
    x - deduct => int step;
    return step * len;
}

<<< walk_dis_to_step(6, 1) >>>;
<<< walk_step_to_dis(9, 3) >>>;

