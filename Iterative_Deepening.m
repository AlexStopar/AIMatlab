GoalState = [1, 2, 3, 4, 5, 6, 7, 8, 0];
RunningTimes = zeros(1, 100);
ClockTimes = zeros(1, 100);
IStates = cell(100, 1);
actionStepMax = 13;


for k = 1:100
    IStates{k} = GoalState;
    for n = 1:randi(actionStepMax)
        IStates{k} = TakeAction(IStates{k}, randi(Actions.DOWN));
    end
end
[IStates, idx, idx2] = uniquecell(IStates);
while length(IStates) < 100
   IStates{length(IStates) + 1} = [];
   IStates{length(IStates)} = GoalState;
   for n = 1:randi(actionStepMax)
        IStates{length(IStates)} = TakeAction(IStates{length(IStates)}, randi(Actions.DOWN));
   end
   [IStates, idx, idx2] = uniquecell(IStates);
end


for j = 1:100
    tic;
    node = struct('state', IStates{j}, 'pathcost', 0);
    if(isequal(node.state, GoalState)) 
        RunningTimes(j) = node.pathcost;
    end
    explored = Queue('struct');
    explored.offer(node);
    runTime = -1;
    clockTime = -1;
    depth = 1;
    while (runTime == -1 && depth < actionStepMax)
        [runTime, clockTime] = dfs_subroutine(node, explored, depth, GoalState);
        depth = depth + 1;
        explored.clear();
        explored.offer(node);
    end
    RunningTimes(j) = runTime;
    ClockTimes(j) = clockTime;
    explored.clear();
end
histogram(RunningTimes);
mean = mean(RunningTimes)
variance = var(RunningTimes)