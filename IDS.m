GoalState = [1, 2, 3, 4, 5, 6, 7, 8, 0];
RunningTimes = zeros(1, 100);
ClockTimes = zeros(1, 100);
IStates = cell(100, 1);
actionStepMax = 20;
ISolutions = cell(100, actionStepMax);
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
    result = -1;
    for depth = 1:actionStepMax
        result = DLS(IStates{j}, depth, GoalState);
        if (result.pathcost > -1)
            break;
        end
    end
    RunningTimes(j) = result.pathcost;
    traceNode = result;
    solutionTrace = 1;
    ISolutions{j}{solutionTrace} = traceNode.state;
    while(~isequal(traceNode.state,IStates{j}))
       solutionTrace = solutionTrace + 1;
       traceNode = traceNode.parent;
       ISolutions{j}{solutionTrace} = traceNode.state;
    end
    ClockTimes(j) = toc;
end

%histogram(RunningTimes);
%Clear workspace before running each time
figure();
scatter(RunningTimes, ClockTimes);
xlabel('RunningTimes');
ylabel('ClockTimes');
mean = mean(RunningTimes)
variance = var(RunningTimes)
