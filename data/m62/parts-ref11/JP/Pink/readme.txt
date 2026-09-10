Jaan Parts, 2020

Vertices format (*.vtx):
{x, y}

x     - x coordinate
y     - y coordinate


Nodes format (*.nod): 
{n, c1, c2, c3, c4, v, a, b, c, d}

n     - node number
c1..4 - color ports,
        =0 - unused color of the root node
        <n - input: number of previously colored neighbor node
        >n - output: number of some next uncolored neighbor node 
v     - vertex number of the graph g481
a..d  - integer vertex coordinates,
        (a+sqrt(33)*b)/12 = x, (sqrt(3)*c+sqrt(11)*d)/12 = y
