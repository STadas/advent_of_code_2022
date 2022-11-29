from pathlib import Path


def xd():
    data = open(str(Path(__file__).parent.absolute()) + "/input").read()#.splitlines()

    for line in data:
        print(line)

    p1 = 0
    p2 = 0
    print(f"{p1=}")
    print(f"{p2=}")


if __name__ == "__main__":
    xd()
