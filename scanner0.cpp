#include <iostream>
#include <vector>
#include <utility>
#include <fstream>
#include <queue>

using namespace std;

typedef pair<int, char> sym;
typedef vector<sym> adjacents;
typedef vector<adjacents> graph;
typedef vector<int> states;

const char EMPTY = -1;

graph dfa = {
	{{1, EMPTY}, {7, EMPTY}},
	{{2, EMPTY}, {4, EMPTY}},
	{{3, 'a'}},
	{{6, EMPTY}},
	{{5, 'b'}},
	{{6, EMPTY}},
	{{1, EMPTY}, {7, EMPTY}},
	{{8, 'a'}},
	{{9, 'b'}},
	{{10, 'b'}},
	{},
};

states emptyClosure(states S) {
	int n = dfa.size();
	vector<bool> visited(n, false);
	queue<int> q;
	states reached;
	for (auto s : S) {
		visited[s] = true;
		q.push(s);
	}
	while (!q.empty()) {
		auto s = q.front(); q.pop();
		for (auto v : dfa[s]) {
			if (v.second == EMPTY && !visited[v.first]) {
				reached.push_back(v.first);
				visited[v.first] = true;
				q.push(v.first);
			}
		}
	}

	return reached;
}

int main(int argc, char** argv) {
	argc--; argv++;
	if (argc == 0) {
		return -1;
	}
	auto reached = emptyClosure({0});
	for (auto x  : reached) {
		cout << x << endl;
	}/*
	ifstream f(argv[0]);
	if (f.is_open()) {
		char c;
		while (f.get(c)) {
			cout << "<" << c << ">: " << ((int)c) << endl;
		}
	}*/

	return 0;
}
